# Dell Optimizer Configurator

**Version 1.2 (Beta)**

**Required installation of Microsoft.net Version 6**

## Description
This Application is a standalone tool for administrators. It allows administrators to make rules of settings for the Dell Optimizer **Version 3.2.212.0** After you have finished all your required settings you can automatically generate a PowerShell script which will execute all required settings on a remote machine. PowerShell supports all Client Management platforms; you can use it with Microsoft Intune or other solutions like Matrix42 or Microsoft SCCM (System Centre Configuration Manager). 

### Change log:
- 1.0     initial tool supports Dell Optimizer Version 2.x only 
- 1.2     **New Functions:**
    * Save and Load of configurations
    * Support of Dell Optimizer Version 3.2.212.0
    * rebuild the PowerShell form scratch
    * PowerShell will be writing Logs in Microsoft Event for later better visibility

## Legal disclaimer:
**THE INFORMATION IN THIS PUBLICATION IS PROVIDED 'AS-IS.' DELL MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND WITH RESPECT TO THE INFORMATION IN THIS PUBLICATION, AND SPECIFICALLY DISCLAIMS IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.**
In no event shall Dell Technologies, its affiliates or suppliers, be liable for any damages whatsoever arising from or related to the information contained herein or actions that you decide to take based thereon, including any direct, indirect,incidental, consequential, loss of business profits or special damages, even if Dell Technologies, its affiliates or suppliers have been advised of the possibility of such damages.

## Dell Configurator GUI

The GUI (Graphical User Interface) supports all Dell Optimizer settings described in the User Guide. 
https://www.dell.com/support/manuals/en-us/dell-optimizer/dell-optimizer-3.1_ug/command-line-interface-for-dell-optimizer?guid=guid-a82481c9-8abf-4a15-9f2b-6011e36c6b19&lang=en-us

![MicrosoftTeams-image](https://user-images.githubusercontent.com/99394991/215116616-84f36e3d-6526-4625-96d1-26fce09ef4ea.png)


## PowerShell

After you have clicked on Generated PowerShell you will get an PowerShell script which includes all your settings. If you run this PowerShell, it will check first which settings a device is supporting and only this one will be changed if needed. If your settings are still existing on a machine the configuration will be skipped.  The PowerShell supports settings and Application learning for optimization as well.

![MicrosoftTeams-image (1)](https://user-images.githubusercontent.com/99394991/215116685-1f5a1d9e-1fa7-4732-b9e2-39c5a1a5a569.png)


## Logging function (by PowerShell script)

The new script will be logging all action in Microsoft Events for later checking by administrators. There are different Log IDs for Application learning, lock/unlock and change settings to make it easier to find failures at you deployment.

![fd03cd62-cf52-4f3f-bb38-0e21584ecdab](https://user-images.githubusercontent.com/99394991/207339606-2d09bd01-755b-48ec-b22a-3472e78e70f4.jpg)

**Return Codes Dell Optimizer**
* 0 Success
* 1 Failure
* 2 Reboot required
* 3 Failed to configure the read-only setting
* 4 Failed to configure licensed feature
* 5 Dell Optimizer service not installed
* 6 Dell Optimizer service is disabled
* 7 Dell Optimizer service is not running
* 8 Another instance of CLI is active
* 9 Another instance of user interface is active
* 10 It requires administrator privilege

**Microsoft Event Log IDs**´
* 10 Dell Optimizer is installed on machine
* 12 Dell Optimizer not found on machine
* 20 Setting change Error
* 21 Setting not changed because of it the same
* 22 Setting Changed
* 23 Setting is Read Only and can not change now
* 24 Setting is not availible on this device
* 30 Unlock change Error
* 31 Unlock not changed because of it the same
* 32 Unlock Changed to false
* 30 Lock change Error
* 31 Lock not changed because of it the same
* 32 Lock Changed to true
* 40 Set Application failure
* 41 Learned/Optimizer Apps on Device
* 42 Add App to learn success full
