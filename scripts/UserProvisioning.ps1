# Automated User Provisioning Script
# Systems Administrator - Ubuntu Freight Solutions
# Author: Sibonelo Lukhele
# Student Number: ST10443746
# Module: XINM6329 Work Integrated Learning
# Date: October 2026
# Purpose: Automates user account creation in Active Directory

param(
    [string]$FirstName,
    [string]$LastName,
    [string]$Department,
    [string]$Manager
)

# Import Active Directory module
Import-Module ActiveDirectory

# Generate username
$Username = ($FirstName.Substring(0,1) + $LastName).ToLower()
$UPN = "$Username@ubuntufreight.co.za"

# Set default password (in production, use a secure vault)
$Password = ConvertTo-SecureString "Welcome@2026!" -AsPlainText -Force

# Create user
New-ADUser -Name "$FirstName $LastName" `
           -SamAccountName $Username `
           -UserPrincipalName $UPN `
           -GivenName $FirstName `
           -Surname $LastName `
           -DisplayName "$FirstName $LastName" `
           -Department $Department `
           -Manager $Manager `
           -AccountPassword $Password `
           -Enabled $true `
           -ChangePasswordAtLogon $true

# Add to department group
Add-ADGroupMember -Identity "$Department-Users" -Members $Username

Write-Host "User $Username created successfully."

