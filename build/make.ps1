$projectVer = "V2.067 R4.3"
$spyName = "Warfare BE V2.067 Lite"
$currentDirectory = [string](Get-Location);
$revisionNumber = "";
$prevBuildRevision = 464;

function EntryPoint
{
	$output = new-object Text.StringBuilder;
	$consoleOut = new-Object System.IO.StringWriter($output);
	[Console]::SetOut($consoleOut);
	
	cls
	$root = [System.IO.Path]::GetFullPath($currentDirectory + "\..");
	$source = "$root\Warfare.Bomba.Takistan";
	
	#-- $root1 = [System.IO.Path]::GetFullPath($currentDirectory + "\..\..");
	#-- $source = "$root1\WarfareBE";
	
	$versionDir = "$root\version\";
	$tmpfolder = [System.IO.Path]::GetTempPath() + "buildwarfare";

	$outputDir = "$currentDirectory\release";
	if ([System.IO.Directory]::Exists($outputDir) -eq $false) {
		$null = new-item -type directory -path $outputDir;
	}
	
	#-- set build version in description
	$revisionNumber = SVN-GetRevision -svnToolsPath "$currentDirectory\svn" -repositoryFolder $source
	SVN-GetHistory -svnToolsPath "$currentDirectory\svn" -repositoryFolder $source -baseRevision "$prevBuildRevision" -headRevision $revisionNumber
	Write-Host "Revision: $revisionNumber";	
	
	preprocess-mission;	
	
	$numplayers = @( 40 );
	
	compile-version -world "Takistan" -gamever "Mando.CO"  -numplayers 40  -desc "Combined Operations - Takistan" -missionMods ""

	#-- build versions without mando missiles
	Remove-Item $tmpfolder\mando_missiles -Recurse -Force -ErrorAction SilentlyContinue;
	foreach($numplayer in $numplayers)
	{
		compile-version -world "Takistan" -gamever "CO"  -numplayers $numplayer  -desc "Combined Operations - Takistan" -missionMods ""
		compile-version -world "Takistan" -gamever "OA"  -numplayers $numplayer  -desc "Operation Arrowhead - Takistan" -missionMods ""

		compile-version -world "Chernarus" -gamever "CO" -numplayers $numplayer  -desc "Combined Operations - Chernarus" -missionMods ""
		compile-version -world "Chernarus" -gamever "A2" -numplayers $numplayer  -desc "ArmA2 Vanilla - Chernarus" -missionMods "" 
	}
	
	compile-version -world "Lingor" -gamever "CO"  -numplayers 40  -desc "Combined Operations - Lingor"
	
	#-- remove temporary folder
	#-- Remove-Item -path $tmpfolder -Recurse -Force;
	
	Write-Host "Build completed."
}

function preprocess-mission {

	Write-Host --- ([DateTime]::Now.ToLongTimeString()) Compile Started: ([IO.Path]::GetFileName($source))
	Write-Host ---

	Write-Host "Copy mission files to temporary folder... " -NoNewline
		Remove-Item -path $tmpfolder -Recurse -Force -ErrorAction SilentlyContinue;
		$null = new-item -type directory -path $tmpfolder;

		#-- copy source files to build folder
		copy-files -source $source -destination $tmpfolder;

		#-- remove debug files
		dir -Path $tmpfolder -Recurse | Where {$_.Name -eq "profiler.h"} | Foreach-Object { Remove-Item $_.FullName };
		Remove-Item $tmpfolder\profiler.sqf
	Write-Host Done
	Write-Host 

	[ArmA2.Script.Logger]::Clear();
	[ArmA2.Script.Logger]::EnableLogToFile = $true;
	[ArmA2.Script.Logger]::LogFileName = "arma2.script.compile.log";
	
	$compiler = New-Object ArmA2.Script.Compile.Compiler;
	$compiler.Settings.EnableMinimization = $false;
	
	[ArmA2.Script.Logger]::WarningDisabled.Clear();
	[ArmA2.Script.Logger]::WarningDisabled.Add([ArmA2.Script.Compile.CompileCode]::PerfomanceIssue);
	
	$context = $compiler.Context;
	
	$context.PublicVariables.Clear();
	$context.ExcludePhrases.Clear();
	$context.ExcludeLines.Clear();
	
    $context.ExcludeLines.Add("PROFILER_BEGIN");
    $context.ExcludeLines.Add("PROFILER_END");
    $context.ExcludeLines.Add("profiler.sqf");
    $context.ExcludeLines.Add("profiler.h");
    $context.ExcludeLines.Add("!isNil `"initProfiler`"");
	$context.ExcludeLines.Add("!isNil `"LogInited`"");
	$context.ExcludeLines.Add("logging.h");
	$context.ExcludeLines.Add("logging.sqf");
	$context.ExcludeLines.Add("call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)(?:[^\w])");
	 
	if ($output.Length -gt 0) { Write-Host $output; }
	$output.Length = 0; 
	 
	$files = dir -Path $tmpfolder -Recurse -Include "*.sqf", "*.fsm" | Where {($_.psIsContainer -eq $false) -and (($_.FullName -match ".*\\mando_missiles\\.*") -ne $true) };
	$files = $files | Where { ($_.FullName -match ".*\\briefing.sqf") -eq $false };
	foreach($x in $files) {

		$filePath = $x.FullName.Replace($tmpfolder+"\","").Trim();
		Write-Host Compile: $filePath;	
		$compiler.CompileFile($x.FullName);
		
		if ($output.Length -gt 0) { Write-Host $output; }
		$output.Length = 0;		
	}
	
	Write-Host ---
	Write-Host --- ([DateTime]::Now.ToLongTimeString()) Compile Done.
	Write-Host
}

function compile-version {
	param ([string]$world, [string]$gamever, [int]$numplayers, [string]$desc, [string]$missionMods)
	
	$projectName =  "WBE$projectVer@$numplayers$gamever.$world" -replace " ", ".";	
	
	Copy-Item "$source\briefing.sqf" "$tmpfolder" -Force
	
	Copy-Item "$versionDir\$gamever@$numplayers.$world\*" "$tmpfolder" -Force
	Write-Host "Package $projectName.pbo" -NoNewline
	
	$mission = "[$numplayers]Warfare $projectVer Bomba Edition $desc"
	
	$patMissioName = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONNAME");
	$patMissioDesc = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONDESCRIPTION");
	$patBuildVersion = [System.Text.RegularExpressions.Regex]::Escape("`$BUILDVERSION");
	
	$spyMission = "$spyName $gamever$missionMods + $world";
	replace-pattern -pattern $patMissioName -replaceTo $spyMission -fileName "$tmpfolder\version.sqf";
	replace-pattern -pattern $patMissioName -replaceTo $spyMission -fileName "$tmpfolder\mission.sqm";
	
	replace-pattern -pattern $patMissioDesc -replaceTo $desc -fileName "$tmpfolder\mission.sqm";
	replace-pattern -pattern $patBuildVersion -replaceTo $revisionNumber -fileName "$tmpfolder\mission.sqm";

	replace-pattern -pattern $patMissioName -replaceTo $mission -fileName "$tmpfolder\briefing.sqf";
	replace-pattern -pattern $patMissioDesc -replaceTo $desc -fileName "$tmpfolder\briefing.sqf";
	replace-pattern -pattern $patBuildVersion -replaceTo $revisionNumber -fileName "$tmpfolder\briefing.sqf";	
	
	
	make-pbo -missionFolder $tmpfolder -outputPbo "$outputDir\$projectName.pbo";	
	
	Write-Host " - [done]";	
};

function replace-pattern {
	param ([string]$fileName, [string]$pattern, [string]$replaceTo)

	$fileInfo = Get-ChildItem -Path $fileName;
    if( $fileInfo.GetType().Name -eq 'FileInfo')
    {
		(Get-Content $fileInfo.FullName) | 
			Foreach-Object {$_ -replace $pattern, $replaceTo} | 
			Set-Content $fileInfo.FullName;
	}
}

function copy-files{
	param ([string]$source, [string]$destination)

	$exclude = @('*.pdb','*.config');
	Get-ChildItem $source -Recurse -Exclude $exclude | Copy-Item -Destination {Join-Path $destination $_.FullName.Substring($source.length)};
}

function make-pbo {
	param ([string]$outputPbo, [string]$missionFolder)

	$info = New-Object System.Diagnostics.ProcessStartInfo("$currentDirectory\cpbo.exe");
	$info.UseShellExecute = $false;
	$info.CreateNoWindow = $true;
	$info.WorkingDirectory = $currentDirectory;

	$info.Arguments = "-y -p ""$missionFolder"" ""$outputPbo"" ";

	$process = New-Object Diagnostics.Process;
	$process.StartInfo = $info;

	[Void] $process.Start();
	[Void] $process.WaitForExit(120000);
}

function SVN-GetRevision {
	param ([string]$svnToolsPath, [string]$repositoryFolder)

    $psi = New-Object System.Diagnostics.ProcessStartInfo($svnToolsPath + "\\svn.exe");
    $psi.WorkingDirectory = $svnToolsPath;
    $psi.Arguments = "info --revision BASE --xml `"$repositoryFolder`"";
    $psi.RedirectStandardOutput = $true;
    $psi.StandardOutputEncoding = [System.Text.Encoding].UTF8;
    $psi.UseShellExecute = $false;
	$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden;
	
    $process = [System.Diagnostics.Process]::Start($psi);
	$doc = New-Object System.Xml.XmlDocument;
    $doc.Load($process.StandardOutput);
	$process.Dispose();

    return $doc.SelectSingleNode("/info/entry/commit").revision;
}

function SVN-GetHistory {
	param ([string]$svnToolsPath, [string]$repositoryFolder, [string]$baseRevision, [string]$headRevision)
	
	$psi = New-Object System.Diagnostics.ProcessStartInfo($svnToolsPath + "\\svn.exe");
    $psi.WorkingDirectory = $svnToolsPath;
    $psi.Arguments = "log --xml --revision $headRevision`:$baseRevision `"$repositoryFolder`"";
    $psi.RedirectStandardOutput = $true;
    $psi.StandardOutputEncoding = [System.Text.Encoding].UTF8;
    $psi.UseShellExecute = $false;
	$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden;
		
    $process = [System.Diagnostics.Process]::Start($psi);
	$doc = New-Object System.Xml.XmlDocument;
    $doc.Load($process.StandardOutput);
	$process.Dispose();
	
	$lines = $doc.DocumentElement.logentry | Foreach-Object { 
		return $_.msg; 
	};
	
	$lines | Set-Content "$outputDir\history.txt";
}

function Add-References {

	$currentDirectory = [string](Get-Location);
	$assemblyPath =$currentDirectory + "\ArmA2.Script.Compiler.dll"; 
	[Void] [System.Reflection.Assembly]::LoadFile( $assemblyPath );
}

Add-References;
EntryPoint;