$hashes = [ordered]@{}

Set-Location $args[0]

Get-ChildItem -File -Recurse -Exclude dalamud.txt, *.zip, *.pdb, *.ipdb | Foreach-Object {
	$key = ($_.FullName | Resolve-Path -Relative).TrimStart(".\\")
	$val = (Get-FileHash $_.FullName -Algorithm MD5).Hash
	$hashes.Add($key, $val)
}

$hashes | ConvertTo-Json | Out-File -FilePath "hashes.json"

$mainhash = (Get-FileHash "hashes.json" -Algorithm MD5).Hash
Set-Location ..
$Json = Get-Content "version" -Raw | ConvertFrom-Json
$Json.Hash = $mainhash
$Json | ConvertTo-Json | Set-Content "version"