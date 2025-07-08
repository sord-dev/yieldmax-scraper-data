[CmdletBinding()]
param (
    [string]$DatabasePath = "test.db"
)

$Date = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
$BackupPath = "test_backup_$Date.db"

try {
    Get-Content $DatabasePath | sqlite3 $BackupPath
}
catch {
    Write-Error $_
}