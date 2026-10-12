# Server Health Check Script
# Systems Administrator - Ubuntu Freight Solutions
# Author: Sibonelo Lukhele
# Student Number: ST10443746
# Module: XINM6329 Work Integrated Learning
# Date: October 2026
# Purpose: Checks CPU, RAM, and disk usage on critical servers

$Servers = @("DC01", "DC02", "File01", "File02", "DB01", "DB02", "App01", "App02")
$Report = @()

foreach ($Server in $Servers) {
    $CPU = Get-Counter "\Processor(_Total)\% Processor Time" -ComputerName $Server
    $RAM = Get-Counter "\Memory\Available MBytes" -ComputerName $Server
    $Disk = Get-PSDrive C -PSProvider FileSystem -ComputerName $Server
    
    $Report += [PSCustomObject]@{
        Server = $Server
        CPU = [math]::Round($CPU.CounterSamples.CookedValue, 2)
        RAM_Free_MB = $RAM.CounterSamples.CookedValue
        Disk_Free_GB = [math]::Round($Disk.Free / 1GB, 2)
        Disk_Total_GB = [math]::Round(($Disk.Used + $Disk.Free) / 1GB, 2)
    }
}

$Report | Export-Csv -Path "C:\Reports\HealthCheck_$(Get-Date -Format 'yyyy-MM-dd').csv" -NoTypeInformation
