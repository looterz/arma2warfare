$projectVer = "V2.065 R3.1Beta"
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

	copy-files -source $source -destination $tmpfolder;
	
	#-- copy common files relative builded version
	copy-files -source "$versionDir\.any" -destination $tmpfolder;
	
	#-- copy required headers to all folders
	$dirs = dir -Path $tmpfolder -Recurse | Where {$_.psIsContainer -eq $true};
	foreach($x in $dirs) {
		Copy-Item "$tmpfolder\profiler.h" $x.FullName
	}
	
	build-version -world "Takistan" -gamever "CO" 	 -desc "Takistan Combined Operations"
	build-version -world "Takistan" -gamever "OA"	 -desc "Takistan Operation Arrowhead"

	build-version -world "Chernarus" -gamever "CO"   -desc "Chernarus Combined Operations"
	build-version -world "Chernarus" -gamever "A2"   -desc "Chernarus Vanilla"		
	
	#-- remove temporary folder
	Remove-Item -path $tmpfolder -Recurse -Force;

	Zip-Compress -zipFileName "c:\package.zip" -folderName $outputDir
	
	Write-Host "Build completed."
}

function build-version {
	param ([string]$world, [string]$gamever, [string]$desc)
	
	$projectName =  "Warfare$projectVer@$gamever.Bomba.Edition.$world" -replace " ", ".";	
	
	Copy-Item "$versionDir\$world.$gamever\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.pbo" -NoNewline
	
	$tmpver = $gamever;
	if ($tmpver.length -gt 0) { $tmpver = $tmpver + " "; }
	
	$mission = "Warfare $projectVer Lite " + $tmpver + "Bomba Edition - $world"
	
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