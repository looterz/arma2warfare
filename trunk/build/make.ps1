$projectVer = "V2.065 R3.1beta"
$currentDirectory = [string](Get-Location);

function EntryPoint
{
	cls
	$root = [System.IO.Path]::GetFullPath($currentDirectory + "\..");
	
	$source = "$root\Warfare@Bomba.Takistan\";
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
		build-version -world "Takistan" -gamever "CO"  -numplayers $numplayer  -desc "Takistan Combined Operations"
		build-version -world "Takistan" -gamever "OA"  -numplayers $numplayer  -desc "Takistan Operation Arrowhead"

		build-version -world "Chernarus" -gamever "CO" -numplayers $numplayer  -desc "Chernarus Combined Operations"
		build-version -world "Chernarus" -gamever "A2" -numplayers $numplayer  -desc "Chernarus Vanilla"		
	}
	
	#-- remove temporary folder
	Remove-Item -path $tmpfolder -Recurse -Force;
	
	Write-Host "Build completed."
}

function preprocess-file {
	param ([string]$fileName)

	Write-Host "Preprocess-file: $fileName";
	
	$fileInfo = Get-ChildItem -Path $fileName;
    if( $fileInfo.GetType().Name -eq 'FileInfo')
    {
		$prevEmpty = $true;
		(Get-Content $fileInfo.FullName) | 
			Foreach-Object { return (preprocess-fileline -fileLine $_); } |
			where { 
			
				$ppEmpty = $prevEmpty;
				if ($_.Trim().Length -eq 0) { $prevEmpty = $true; } else { $prevEmpty = $false; };
				if ($ppEmpty -eq $true -and $prevEmpty -eq $true) { return $false; }
				return ($_ -ne "@PREPROCESS-EXCLUDE"); 
			} |
			Set-Content $fileInfo.FullName;
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
		
		$fileLine = $fileLine -replace "format.*\[.*call Log.+?;", "";
		
		$fileLine = $fileLine -replace "`"`"[^`"].*call Log.+?;", ""; #-- logger in fsm
		$fileLine = $fileLine -replace "`".*`".*call Log.+?;", "";
		$fileLine = $fileLine -replace "'.*'.*call Log.+?;", "";
	}
	
	return $fileLine;	
	
};

function build-version {
	param ([string]$world, [string]$gamever, [int]$numplayers, [string]$desc)
	
	$projectName =  "Warfare$projectVer@$gamever.$numplayers.Bomba.Edition.$world" -replace " ", ".";	
	
	Copy-Item "$versionDir\$gamever@$numplayers.$world\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.pbo" -NoNewline
	
	$tmpver = $gamever;
	if ($tmpver.length -gt 0) { $tmpver = $tmpver + " "; }
	
	$mission = "Warfare $projectVer Lite $tmpver@$numplayers Bomba Edition - $world"
	
	$patMissioName = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONNAME");
	$patMissioDesc = [System.Text.RegularExpressions.Regex]::Escape("`$MISSIONDESCRIPTION");
	replace-pattern -pattern $patMissioName -replaceTo $mission -fileName "$tmpfolder\version.sqf";
	
	replace-pattern -pattern $patMissioName -replaceTo $mission -fileName "$tmpfolder\mission.sqm";
	replace-pattern -pattern $patMissioDesc -replaceTo $desc -fileName "$tmpfolder\mission.sqm";
	
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

EntryPoint;