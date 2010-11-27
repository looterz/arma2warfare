$projectVer = "V2.065 R3.2beta"
$currentDirectory = [string](Get-Location);
$revisionNumber = "";

function EntryPoint
{
	cls
	$root = [System.IO.Path]::GetFullPath($currentDirectory + "\..");
	
	$source = "$root\Warfare.Bomba.Takistan";
	$versionDir = "$root\version\";
	$tmpfolder = [System.IO.Path]::GetTempPath() + "buildwarfare";
	

	$outputDir = "$currentDirectory\release";
	if ([System.IO.Directory]::Exists($outputDir) -eq $false) {
		$null = new-item -type directory -path $outputDir;
	}
	
	Remove-Item -path $tmpfolder -Recurse -Force -ErrorAction SilentlyContinue;
	$null = new-item -type directory -path $tmpfolder;

	#-- copy source files to build folder
	copy-files -source $source -destination $tmpfolder;

	#-- set build version in description
	$revisionNumber = SVN-GetRevision -svnToolsPath "$currentDirectory\svn" -repositoryFolder $source

	#-- remove debug files
	dir -Path $tmpfolder -Recurse | Where {$_.Name -eq "profiler.h"} | Foreach-Object { Remove-Item $_.FullName };
	Remove-Item $tmpfolder\logging.sqf
	Remove-Item $tmpfolder\profiler.sqf
	
	#-- preprocess files, remove debug scripts
	$files = dir -Path $tmpfolder -Recurse -Include "*.sqf", "*.fsm" | Where {$_.psIsContainer -eq $false};
	foreach($x in $files) {
		preprocess-file -fileName $x.FullName;
	}
	
	$numplayers = @( 40, 64 );
	foreach($numplayer in $numplayers)
	{
		compile-version -world "Takistan" -gamever "CO"  -numplayers $numplayer  -desc "Combined Operations - Takistan"
		compile-version -world "Takistan" -gamever "OA"  -numplayers $numplayer  -desc "Operation Arrowhead - Takistan"

		compile-version -world "Chernarus" -gamever "CO" -numplayers $numplayer  -desc "Combined Operations - Chernarus"
		compile-version -world "Chernarus" -gamever "A2" -numplayers $numplayer  -desc "ArmA2 Vanilla - Chernarus"		
	}
	
	#-- remove temporary folder
	#-- Remove-Item -path $tmpfolder -Recurse -Force;
	
	Write-Host "Build completed."
}

function preprocess-file {
	param ([string]$fileName)

	Write-Host "Preprocess-file: $fileName";
	
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
		
		$fileLine = $fileLine -replace "`"`".+?`"`"\s*call\s\s*Log.+?;", ""; #-- logger in fsm
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
	param ([string]$world, [string]$gamever, [int]$numplayers, [string]$desc)
	
	$projectName =  "Warfare$projectVer@$gamever.$numplayers.Bomba.Edition.$world" -replace " ", ".";	
	
	Copy-Item "$source\briefing.sqf" "$tmpfolder" -Force
	
	Copy-Item "$versionDir\$gamever@$numplayers.$world\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.pbo" -NoNewline
	
	$mission = "Warfare $projectVer Bomba Edition $desc"
	
	$patMissioName = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONNAME");
	$patMissioDesc = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONDESCRIPTION");
	$patBuildVersion = [System.Text.RegularExpressions.Regex]::Escape("`$BUILDVERSION");
	
	replace-pattern -pattern $patMissioName -replaceTo $mission -fileName "$tmpfolder\version.sqf";
	
	replace-pattern -pattern $patMissioName -replaceTo $mission -fileName "$tmpfolder\mission.sqm";
	replace-pattern -pattern $patMissioDesc -replaceTo $desc -fileName "$tmpfolder\mission.sqm";

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
    $psi.StandardOutputEncoding = [System.Text.Encoding].Default;
    $psi.UseShellExecute = $false;
	$psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden;
	
    $process = [System.Diagnostics.Process]::Start($psi);
	$doc = New-Object System.Xml.XmlDocument;
    $doc.Load($process.StandardOutput);
	$process.Dispose();

    return $doc.SelectSingleNode("/info/entry/commit").revision;
}

EntryPoint;