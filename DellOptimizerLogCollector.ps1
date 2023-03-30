<#
_author_ = Sven Riebe <sven_riebe@Dell.com>
_twitter_ = @SvenRiebe
_version_ = 1.0.0
_Dev_Status_ = Test
Copyright © 2023 Dell Inc. or its subsidiaries. All Rights Reserved.

No implied support and test in test environment/device before using in any production environment.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

<#Version Changes

1.0.0   inital version

Knowing Issues


#>

<#
.Synopsis
    This PowerShell will deploy settings for Dell Command | Update, Dell Optimizer, Dell Display Manager and Dell Client BIOS (WMI) to this Client. This script using a central policy file which defining which setting are assigned by administrators. 
    IMPORTANT: This script does not reboot the system to apply or query system.
    IMPORTANT: Dell Optimizer need to install first on the devices.


.DESCRIPTION
   PowerShell helping to collecting Dell Optimizer Logs for support.
#>

################################################################
###  Variables Section                                       ###
################################################################


$AppIdentity = Get-AppPackage | Where-Object Name -like "DellInc.DellOptimizer*"
$ProgramDataID = Get-ItemPropertyValue HKLM:\SOFTWARE\Dell\DellOptimizer -Name DataFolderName
$PathUILog = $env:USERPROFILE + "\AppData\local\Packages\" + $AppIdentity.PackageFamilyName + "\LocalState\Logs"
$PathServiceLog = $env:ProgramData + "\" + $ProgramDataID + "\DellOptimizer"
$NameUILog = "DellOptimizerUi.log"
$NameServiceLog = "Service.Log"
$NameZip = "DOlogs.zip"
$PathTempFolder = "C:\Temp\DOLogs"
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$RunDate = Get-Date -Format yyyyMMdd
$DeviceSN = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber


################################################################
###  Program Section                                         ###
################################################################

# Checking if Dell Optimizer is installed
$CheckInstallDO = Get-AppPackage | Where-Object Name -like "DellInc.DellOptimizer*"

If ($null -ne $CheckInstallDO)
    {

        Write-Host "Dell Optimizer is installed, Log collection is starting now" -BackgroundColor Green

        # check if temp folder is available and generate if needed
        $CheckFolderTemp = Test-Path -Path $PathTempFolder

        If ($CheckFolderTemp -ne $true)
            {

                Write-Host "Folder" $PathTempFolder "is not availble" -BackgroundColor Yellow
                New-Item -Path $PathTempFolder -ItemType Directory -Force
                Write-Host "Folder" $PathTempFolder "is generated" -BackgroundColor Green

            }
        else 
            {
                
                Write-Host "Folder" $PathTempFolder "is availble" -BackgroundColor Green

            }

        # copy logs to temp folder
        Copy-Item -Path $PathUILog\$NameUILog -Destination $PathTempFolder
        Copy-Item -Path $PathServiceLog\$NameServiceLog -Destination $PathTempFolder


        # zip the logs and copy to user desktop
        Compress-Archive -LiteralPath $PathTempFolder -DestinationPath $PathTempFolder\DOlogs
        move-item -path $PathTempFolder\$NameZip $DesktopPath
        Rename-Item -Path $DesktopPath\$NameZip "DOLogs-$DeviceSN-$RunDate.zip"

        # check if Log files are on desktop
        $CheckFileLog = Test-Path -Path $DesktopPath\"DOLogs-$DeviceSN-$RunDate.zip"

        If ($CheckFileLog -eq $true)
            {
        
                Write-Host "Logfile Zip DOLogs-$DeviceSN-$RunDate.zip is stored" $DesktopPath -BackgroundColor Green
        
            }
        else 
            {
                        
                Write-Host "Error: Logfile Zip DOLogs-$DeviceSN-$RunDate.zip is not stored" $DesktopPath -BackgroundColor Red
        
            }
        
        # Delete logs from temp folder
        Remove-Item -path $PathTempFolder -Recurse
        
        # check if temp folder is deleted
        $CheckFolderTemp = Test-Path -Path $PathTempFolder

        If ($CheckFolderTemp -ne $true)
            {

                Write-Host "Folder" $PathTempFolder "is deleted" -BackgroundColor Green

            }
        else 
            {
                
                Write-Host "Folder" $PathTempFolder "is not delete. Please do it manually" -BackgroundColor Red

            }

    }
else
    {

        Write-Host "Dell Optimizer is not installed, program stops. No Logs are collect" -BackgroundColor Red

    }
