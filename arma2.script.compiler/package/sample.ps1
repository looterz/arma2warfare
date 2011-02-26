$currentDirectory = [string](Get-Location);

function EntryPoint
{
	$output = new-object Text.StringBuilder;
	$consoleOut = new-Object System.IO.StringWriter($output);
	[Console]::SetOut($consoleOut);
	
	cls
	$root = [System.IO.Path]::GetFullPath($currentDirectory + "\");
	$source = "$root\sampleMission";
	$tmpfolder = [System.IO.Path]::GetTempPath() + "_sampleMission.compiled";

	compile-mission;	
	
	Write-Host --- ([DateTime]::Now.ToLongTimeString()) Build Completed.
}

function compile-mission {

	Write-Host --- ([DateTime]::Now.ToLongTimeString()) Compile Started: ([IO.Path]::GetFileName($source))
	Write-Host ---

	[ArmA2.Script.Logger]::Clear();
	[ArmA2.Script.Logger]::EnableLogToFile = $true;
	[ArmA2.Script.Logger]::LogFileName = "arma2.script.compile.log";
	
	$compiler = New-Object ArmA2.Script.Compile.Compiler;
	$compiler.Settings.EnableMinimization = $false;
	
	#-- remove temporary directory
	Remove-Item -path $tmpfolder -Recurse -Force -ErrorAction SilentlyContinue;
	
	#-- create directory
	$null = new-item -type directory -path $tmpfolder;

	#-- copy source files to build folder
	copy-files -source $source -destination $tmpfolder;

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
	 
	#-- first pass remove comments, debug scripts, obfuscate local variables
	#
	$files = dir -Path $tmpfolder -Recurse -Include "*.sqf", "*.fsm" | Where {($_.psIsContainer -eq $false) -and (($_.FullName -match ".*\\mando_missiles\\.*") -ne $true) };
	$files = $files | Where { ($_.FullName -match ".*\\briefing.sqf") -eq $false };
	foreach($x in $files) {

		$filePath = $x.FullName.Replace($tmpfolder+"\","").Trim();
		Write-Host Compile: $filePath;	
		$compiler.CompileFile($x.FullName);
		
		if ($output.Length -gt 0) { Write-Host $output; }
		$output.Length = 0;		
	}
	
	Write-Host --- ([DateTime]::Now.ToLongTimeString()) Compile Done.
}

function copy-files{
	param ([string]$source, [string]$destination)

	$exclude = @('*.pdb','*.config');
	Get-ChildItem $source -Recurse -Exclude $exclude | Copy-Item -Destination {Join-Path $destination $_.FullName.Substring($source.length)};
}

function Add-References {

	$currentDirectory = [string](Get-Location);
	$assemblyPath =$currentDirectory + "\ArmA2.Script.Compiler.dll"; 
	[Void] [System.Reflection.Assembly]::LoadFile( $assemblyPath );
}

Add-References;
EntryPoint;