# Backup Verification Script
# Systems Administrator - Ubuntu Freight Solutions
# Author: Sibonelo Lukhele
# Student Number: ST10443746
# Module: XINM6329 Work Integrated Learning
# Date: October 2026
# Purpose: Verifies that backups completed successfully

$BackupPath = "\\BackupServer\Backups"
$LogFile = "C:\Logs\BackupVerification.log"
$Date = Get-Date -Format "yyyy-MM-dd"

# Check backup files
$Backups = Get-ChildItem -Path $BackupPath -Filter "*$Date*" -Recurse

if ($Backups.Count -gt 0) {
    $Message = "SUCCESS: $($Backups.Count) backups found for $Date"
    Add-Content -Path $LogFile -Value "$(Get-Date): $Message"
    
    Send-MailMessage -To "sysadmin@ubuntufreight.co.za" `
                     -From "backup@ubuntufreight.co.za" `
                     -Subject "Backup Verification - $Date" `
                     -Body $Message `
                     -SmtpServer "smtp.ubuntufreight.co.za"
} else {
    $Message = "FAILURE: No backups found for $Date"
    Add-Content -Path $LogFile -Value "$(Get-Date): $Message"
    
    Send-MailMessage -To "sysadmin@ubuntufreight.co.za" `
                     -From "backup@ubuntufreight.co.za" `
                     -Subject "ALERT: Backup Failure - $Date" `
                     -Body $Message `
                     -SmtpServer "smtp.ubuntufreight.co.za"
}
