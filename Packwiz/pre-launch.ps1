# By Ultrasonic1209

# Function to check system memory and adjust JVM args
function Get-MemorySettings {
    # Get total physical memory in GB
    $totalMemoryGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    Write-Output "Total System Memory: $totalMemoryGB GB"
    
    # Calculate recommended memory allocation
    if ($totalMemoryGB -le 4) {
        # Low-end systems (≤4GB)
        $minMem = 1024
        $maxMem = 2048
        Write-Output "Low memory system detected. Adjusting memory allocation..."
    }
    elseif ($totalMemoryGB -le 8) {
        # Medium systems (5-8GB)
        $minMem = 2048
        $maxMem = 4096
        Write-Output "Medium memory system detected. Using moderate memory allocation..."
    }
    elseif ($totalMemoryGB -le 16) {
        # High-end systems (9-16GB)
        $minMem = 4096
        $maxMem = 8192
        Write-Output "High memory system detected. Using recommended memory allocation..."
    }
    else {
        # Very high-end systems (>16GB)
        $minMem = 8192
        $maxMem = 12288
        Write-Output "High-end system detected. Using maximum memory allocation..."
    }

    # Update instance configuration if it exists
    $instanceCfgPaths = @(
        ".\.minecraft\instance.cfg",
        ".\minecraft\instance.cfg",
        "..\instance.cfg"
    )

    foreach ($cfgPath in $instanceCfgPaths) {
        if (Test-Path $cfgPath) {
            $content = Get-Content $cfgPath
            $content = $content -replace "MinMemAlloc=\d+", "MinMemAlloc=$minMem"
            $content = $content -replace "MaxMemAlloc=\d+", "MaxMemAlloc=$maxMem"
            Set-Content $cfgPath $content
            Write-Output "Updated memory settings in $cfgPath"
            break
        }
    }
}

# Function to download and extract Distant Horizons
function Get-DistantHorizons {
    param($version)
    # Check if version is supported
    $supportedVersions = @("1.21", "1.21.1", "1.21.3", "1.21.4")
    if ($supportedVersions -notcontains $version) {
        Write-Output "Warning: Distant Horizons is not supported for Minecraft $version"
        return
    }

    Write-Output "Downloading Distant Horizons for Minecraft $version..."
    # Use 1.21.1 build for 1.21 and 1.21.1
    $buildVersion = if ($version -in @("1.21", "1.21.1")) { "1.21.1" } else { $version }
    $url = "https://gitlab.com/distant-horizons-team/distant-horizons/-/jobs/artifacts/main/download?job=build:%20[$buildVersion]"
    $zipFile = "dh-$version.zip"
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $zipFile
        if (Test-Path "temp-dh") {
            Remove-Item "temp-dh" -Recurse -Force
        }
        Expand-Archive $zipFile -DestinationPath "temp-dh"
        $jarFile = Get-ChildItem "temp-dh/fabric/build/libs/distanthorizons-*.jar" | Select-Object -First 1
        if ($jarFile) {
            Move-Item $jarFile.FullName "mods/distanthorizons-$version.jar" -Force
            Write-Output "Successfully installed Distant Horizons for $version"
        } else {
            Write-Output "Error: Could not find Distant Horizons jar in the downloaded artifacts"
        }
    }
    catch {
        Write-Output "Error downloading/extracting Distant Horizons: $_"
    }
    finally {
        if (Test-Path $zipFile) { Remove-Item $zipFile }
        if (Test-Path "temp-dh") { Remove-Item "temp-dh" -Recurse -Force }
    }
}

$mods = @(
    'ModYouDislike.jar'
    'AnotherMod.jar'
)

# Check memory and adjust settings before launching
Get-MemorySettings

# Upgrading Fabulously Optimized
Write-Output "Checking for FO updates..."
Set-Location ..

$json = Get-Content "mmc-pack.json" | ConvertFrom-Json

$table = $json.components | Where-Object { $_.cachedName -eq "Minecraft" }
$mcVersion = $table.version

if (Test-Path -Path ".\.minecraft") {
    Set-Location ".\.minecraft"
} else {
    Set-Location ".\minecraft"
}

$processOptions = @{
    FilePath = $Env:INST_JAVA
    ArgumentList = "-jar packwiz-installer-bootstrap.jar",
        "https://raw.githubusercontent.com/Fabulously-Optimized/fabulously-optimized/main/Packwiz/$mcVersion/pack.toml"
}
Start-Process @processOptions -Wait

# Download Distant Horizons if needed
switch ($mcVersion) {
    "1.21" { Get-DistantHorizons "1.21" }
    "1.21.1" { Get-DistantHorizons "1.21.1" }
    "1.21.3" { Get-DistantHorizons "1.21.3" }
    "1.21.4" { Get-DistantHorizons "1.21.4" }
    default { Write-Output "Note: Distant Horizons is not configured for Minecraft $mcVersion" }
}

# Disabling the mods
Write-Output "Disabling mods..."

Set-Location ".\mods"
foreach ($mod in $mods) {
    Move-Item -Path $mod -Destination "$mod.disabled" -Force

    if ($?) {
        Write-Output "$mod disabled successfully!"
    }
}
