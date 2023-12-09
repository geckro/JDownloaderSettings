# If JDownloader is in a custom installation directory, change this line.
# By default, it is C:\Program Files\JDownloader 
$INSTALL_DIR="C:\Program Files\JDownloader"

# Check if the installation directory is valid
if (!(Test-Path "$INSTALL_DIR\JDownloader2.exe" -PathType leaf)) {
    Write-Host "ERROR: The install directory is missing JDownloader2.exe. You may have chosen the wrong directory."
    Exit 0
}
if (!(Test-Path "$INSTALL_DIR\cfg")) {
    Write-Host "ERROR: The install directory is missing cfg. You should run JDownloader first before continuing."
    Exit 0
}

# GraphicalUserInterfaceSettings
$GUI = 'org.jdownloader.settings.GraphicalUserInterfaceSettings.json'
$JSON_GUI = Get-Content -Path "$INSTALL_DIR\cfg\$GUI" | ConvertFrom-Json
$gui_keys = @{
    "donatebuttonstate" = 'CUSTOM_HIDDEN'
    "bannerenabled" = $false
    "premiumalertetacolumnenabled" = $false
    "premiumalerttaskcolumnenabled" = $false
    "premiumalertspeedcolumnenabled" = $false
    "specialdealoboomdialogvisibleonstartup" = $false
    "specialdealsenabled" = $false
    "clipboardmonitored" = $false
    "clipboarddisabledwarningflashenabled" = $false
    "premiumdisabledwarningflashenabled" = $false
}
foreach ($key_name in $gui_keys.Keys) {
    if ($JSON_GUI.$key_name -ne $null) {
        $JSON_GUI.$key_name = $gui_keys[$key_name]
        Write-Host "Key '$key_name' modified. New value: $($JSON_GUI.$key_name)."
    } else {
        Write-Host "Key '$key_name' not found in the JSON file."
    }
}
$JSON_GUI | ConvertTo-Json -Compress | Set-Content -Path "$INSTALL_DIR\cfg\$GUI" -Force

# Packagizer
$PACKAGIZER = 'org.jdownloader.controlling.packagizer.PackagizerSettings.json'
$JSON_PACKAGIZER = Get-Content -Path "$INSTALL_DIR\cfg\$PACKAGIZER" | ConvertFrom-Json
$packagizer_keys = @{
    "packagizerenabled" = $false
}
foreach ($key_name in $packagizer_keys.Keys) {
    if ($JSON_PACKAGIZER.$key_name -ne $null) {
        $JSON_PACKAGIZER.$key_name = $packagizer_keys[$key_name]
        Write-Host "Key '$key_name' modified. New value: $($JSON_PACKAGIZER.$key_name)."
    } else {
        Write-Host "Key '$key_name' not found in the JSON file."
    }
}
$JSON_PACKAGIZER | ConvertTo-Json -Compress | Set-Content -Path "$INSTALL_DIR\cfg\$PACKAGIZER" -Force

# Archive Extractor
$EXTRACTOR = 'org.jdownloader.extensions.extraction.ExtractionExtension.json'
$JSON_EXTRACTOR = Get-Content -Path "$INSTALL_DIR\cfg\$EXTRACTOR" | ConvertFrom-Json
$packagizer_keys = @{
    "enabled" = $false
}
foreach ($key_name in $packagizer_keys.Keys) {
    if ($JSON_EXTRACTOR.$key_name -ne $null) {
        $JSON_EXTRACTOR.$key_name = $packagizer_keys[$key_name]
        Write-Host "Key '$key_name' modified. New value: $($JSON_EXTRACTOR.$key_name)."
    } else {
        Write-Host "Key '$key_name' not found in the JSON file."
    }
}
$JSON_EXTRACTOR | ConvertTo-Json -Compress | Set-Content -Path "$INSTALL_DIR\cfg\$EXTRACTOR" -Force

