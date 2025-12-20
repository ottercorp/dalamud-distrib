Remove-Item -Force -Recurse .\scratch\*.pdb -ErrorAction SilentlyContinue
Remove-Item -Force -Recurse .\scratch\*.xml -ErrorAction SilentlyContinue

# Define the target path
$targetPath = ".\scratch\runtimes"

# Check if the path exists
if (-not (Test-Path $targetPath)) {
    Write-Host "Path does not exist: $targetPath"
    exit
}

# Get all immediate subdirectories, excluding 'win-x64'
$foldersToRemove = Get-ChildItem -Path $targetPath -Directory | Where-Object { $_.Name -ne "win-x64" }

# Remove each folder
foreach ($folder in $foldersToRemove) {
    Write-Host "Deleting folder: $($folder.FullName)"
    Remove-Item -Path $folder.FullName -Recurse -Force
}

Write-Host "Cleanup complete."
