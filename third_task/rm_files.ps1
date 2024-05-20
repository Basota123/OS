param(
    [string]$extension
)

if (-not $extension) {
    Write-Host "Использование: .\delete_files_with_extension.ps1 <расширение_файла>"
    exit 1
}

Get-ChildItem -Filter "*.$extension" | Remove-Item