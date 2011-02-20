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

	Remove-Item -path $tmpfolder -Recurse -Force -ErrorAction SilentlyContinue;
	$null = new-item -type directory -path $tmpfolder;

	#-- copy source files to build folder
	copy-files -source $source -destination $tmpfolder;

	#-- remove debug files
	dir -Path $tmpfolder -Recurse | Where {$_.Name -eq "profiler.h"} | Foreach-Object { Remove-Item $_.FullName };
	Remove-Item $tmpfolder\profiler.sqf
	
	[ArmA2.Script.GlobalSettings]::AllowMinimize = $false;
	
	[ArmA2.Script.Logger]::WarningDisabled.Clear();
	[ArmA2.Script.Logger]::WarningDisabled.Add([ArmA2.Script.CompileCode]::PerfomanceIssue);
	
	[ArmA2.Script.GlobalSettings]::PublicVariables.Clear();
	[ArmA2.Script.GlobalSettings]::ExcludePhrases.Clear();
	[ArmA2.Script.GlobalSettings]::ExcludeLines.Clear();
	
     [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("PROFILER_BEGIN");
     [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("PROFILER_END");
     [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("profiler.sqf");
     [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("profiler.h");
     [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("!isNil `"initProfiler`"");
	 [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("!isNil `"LogInited`"");
	 [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("logging.h");
	 [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("logging.sqf");
	 [ArmA2.Script.GlobalSettings]::ExcludeLines.Add("call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)(?:[^\w])");
	 
     #-- [ArmA2.Script.GlobalVars]::ExcludePhrases.Add("format[\[].+?[\]]\s* call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)");
     #-- [ArmA2.Script.GlobalVars]::ExcludePhrases.Add("`"(?:[^`"\\]|\\.|\`"\`")*""\s*call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)");
     #-- [ArmA2.Script.GlobalVars]::ExcludePhrases.Add("'(?:[^'\\]|\\.|'')*'\s*call Log(Inform|High|Medium|Warning|Error|Trace|Unexpected|Notify)");	
	
	
	#-- first pass remove comments, debug scripts, obfuscate local variables
	#
	$files = dir -Path $tmpfolder -Recurse -Include "*.sqf", "*.fsm" | Where {($_.psIsContainer -eq $false) -and (($_.FullName -match ".*\\mando_missiles\\.*") -ne $true) };
	$files = $files | Where { ($_.FullName -match ".*\\briefing.sqf") -eq $false };
	foreach($x in $files) {

		Write-Host "Compile: "$x.FullName;	
		
		#-- preprocess-file -fileName $x.FullName;
		$compiler = New-Object ArmA2.Script.Compiler
		$compiler.CompileFile($x.FullName);
		
		if ($output.Length -gt 0) { Write-Host $output; }
		$output.Length = 0;		
	}

	#-- $publicVars = [ArmA2.Script.Compiler]::GetPublicVarsOrderByUsage();	
	#-- foreach($x in $publicVars) { 
	#-- 		write-host $x;
	#-- }

	#-- second pass. collect stats about how often public variable used
	#
	#-- [ArmA2.Script.Compiler]::ResetPublicUsage();
	#-- foreach($x in $files) {
	#--   	[ArmA2.Script.Compiler]::AddPublicVariablesUsageStat($x.FullName);
	#-- }	
	
	#-- $publicVars = [ArmA2.Script.Compiler]::GetPublicVarsOrderByUsage();	
	#-- foreach($x in $publicVars) { 
	#-- 		write-host $x;
	#-- }
}

function preprocess-file {
	param ([string]$fileName)




	
	$fileInfo = Get-ChildItem -Path $fileName;
    if( $fileInfo.GetType().Name -eq 'FileInfo')
    {
		$prevEmpty = $true;
		$lines = (Get-Content $fileInfo.FullName) | 
			Foreach-Object { return (preprocess-fileline -fileLine $_); } |
			where { 
				$ppEmpty = $prevEmpty;
				if ($_.Trim().Length -eq 0) { return $false; };
				return ($_ -ne "@PREPROCESS-EXCLUDE"); 
		};

		#if ( ($fileName -match ".*\.fsm") -eq $false) 
		if ($false)
		{
			$mergedLines = @();
			$textLine = "";
			foreach($line in $lines) {
				
				$processed = $false;
				if ($line -match "#ifdef" -or
					$line -match "#endif" -or
					$line -match "#include" -or
					$line -match "#define")
					{
						$textLine = $textLine.Trim();
						if ($textLine.Length -ne 0) {
							$mergedLines += $textLine;
						}
						$mergedLines += $line;
						$textLine = "";
						$processed = $true;
				}
				
				if ($processed -eq $false)
				{
					$textLine = $textLine + $line;
				}			
			}
			$mergedLines += $textLine;
			$lines = $mergedLines;
			$lines = $lines | Foreach-Object { return (obfuscate-fileline -fileLine $_); };
		}		

		$lines | Set-Content $fileInfo.FullName;
	}	
}

function preprocess-fileline {
	param ([string]$fileLine)
	
	#$regexOption = [System.Text.RegularExpressions.RegexOptions]::Compiled -or [System.Text.RegularExpressions.RegexOptions]::IgnoreCase 
	#	-or [System.Text.RegularExpressions.RegexOptions]::IgnorePatternWhitespace;	
	
	if ($fileLine -match "PROFILER_BEGIN" -or 
	    $fileLine -match "PROFILER_END" -or
		$fileLine -match "!isNil ""LogInited""" -or
		
		$fileLine -match "logging.sqf" -or
		$fileLine -match "profiler.sqf" -or
		$fileLine -match "profiler.h" -or
		$fileLine -match "!isNil ""initProfiler"""
		)
	{	
		$fileLine = "@PREPROCESS-EXCLUDE"; 
	}		
	
	#-- remove all logger references
	if ($fileLine -match "call Log") {
		
		$fileLine = $fileLine -replace "format\s*\[.*\]\s*call\s\s*Log.+?;", "";	#-- format [] call Log*;
		
		$fileLine = $fileLine -replace "`"`"`">\*/`"", "@FSMSYS@"; #-- logger in fsm
		$fileLine = $fileLine -replace "`"`".+?`"`"\s*call\s\s*Log.+?;", ""; #-- logger in fsm
		$fileLine = $fileLine -replace "@FSMSYS@", "`"`"`">*/`""; #-- logger in fsm
		
		$fileLine = $fileLine -replace "`".+?`"\s*call\s\s*Log.+?;", "";
		$fileLine = $fileLine -replace "'.+?'\s*call\s\s*Log.+?;", "";
	}
	
	#$fileLine = $fileLine -replace "\/\/\s.*", "";	#-- remove comments
	#$fileLine = $fileLine -replace "\/\/-.*", "";	#-- remove comments
	#$fileLine = $fileLine -replace "\/\*.+?\*/", "";	#-- remove comments
	
	
	return $fileLine;	
};	


function obfuscate-fileline {
	param ([string]$fileLine)	
	
	$syschars = @( "=", "(", ")", "[", "]", "{", "}", "==", "!=", "||", "&&", "+", "-", "/", "*", ",", ";", ":", ">", "<", "<=", ">=" );
	
	foreach($ch in $syschars) {
	
		$regex = "\s*" + [System.Text.RegularExpressions.Regex]::Escape($ch) + "\s*";
		$fileLine = $fileLine -replace $regex, $ch;
	}
	
	$fileLine = $fileLine -replace ";\s*;", ";";
	
	$fileLine = $fileLine -replace ",\s*}", "}";
	$fileLine = $fileLine -replace ",\s*]", "]";
	$fileLine = $fileLine -replace "\/\*.+?\*/", "";	#-- remove comments

	$fileLine = $fileLine -replace "`"\s*\\n\s*`"", "";		#-- "   \n   "
	$fileLine = $fileLine.Trim();
	
	return $fileLine;	
	
};

function compile-version {
	param ([string]$world, [string]$gamever, [int]$numplayers, [string]$desc, [string]$missionMods)
	
	$projectName =  "WBE$projectVer@$numplayers$gamever.$world" -replace " ", ".";	
	
	Copy-Item "$source\briefing.sqf" "$tmpfolder" -Force
	
	Copy-Item "$versionDir\$gamever@$numplayers.$world\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.pbo" -NoNewline
	
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