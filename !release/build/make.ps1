$projectName = "Warfare_V2065.R3@Bomba";
$buildRelease = $true;
#-- $mode = "debug";

$currentDirectory = [string](Get-Location);

function EntryPoint
{
	cls
	$source = [System.IO.Path]::GetFullPath($currentDirectory + "\..\..\");
	$tmpfolder = [System.IO.Path]::GetTempPath() + "buildwarfare";

	Remove-Item -path $tmpfolder -Recurse -Force -ErrorAction SilentlyContinue;
	$null = new-item -type directory -path $tmpfolder;

	copy-files -source $source -destination $tmpfolder;
	Remove-Item -path "$tmpfolder\!release" -Recurse -Force;
	
	Copy-Item "$source\!release\profiler.h" "$tmpfolder\profiler.h";
	Copy-Item "$source\!release\profiler.sqf" "$tmpfolder\profiler.sqf";

	$dirs = dir -Path $tmpfolder -Recurse | Where {$_.psIsContainer -eq $true};
	foreach($x in $dirs)
	{
		Copy-Item "$tmpfolder\profiler.h" $x.FullName
	}
	
	#-- Begin compile pbo
	#--
	$outputDir = "$currentDirectory\release";
	if ([System.IO.Directory]::Exists($outputDir) -eq $false) {
		$null = new-item -type directory -path $outputDir;
	}
	
	#-- Takistan Combined Operations
	$world = "Takistan";
	$version = "CO"
	Copy-Item "$source\!release\$world.$version\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.$version.$world.pbo"
	make-pbo -missionFolder $tmpfolder -outputPbo "$outputDir\$projectName.$version.$world.pbo";
 
 	#-- Takistan Operation Arrowhead
	$world = "Takistan";
	$version = "OA"
	Copy-Item "$source\!release\$world.$version\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.$version.$world.pbo"
	make-pbo -missionFolder $tmpfolder -outputPbo "$outputDir\$projectName.$version.$world.pbo";
	
	#-- Chernarus Combined Operations	
	$world = "Chernarus";
	$version = "CO"
	Copy-Item "$source\!release\$world.$version\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.$version.$world.pbo"
	make-pbo -missionFolder $tmpfolder -outputPbo "$outputDir\$projectName.$version.$world.pbo";
	
	#-- Chernarus Vanilla	
	$world = "Chernarus";
	$version = "A2"
	Copy-Item "$source\!release\$world.$version\*" "$tmpfolder" -Force
	Write-Host "Compile $projectName.$version.$world.pbo"
	make-pbo -missionFolder $tmpfolder -outputPbo "$outputDir\$projectName.$version.$world.pbo";
	
	
	#-- remove temporary folder
	Remove-Item -path $tmpfolder -Recurse -Force;
	
	Write-Host "Build completed."
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
	$process.WaitForExit(120000);
}

EntryPoint;