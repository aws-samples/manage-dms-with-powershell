#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$EndpointSettings = @{  "EndpointIdentifier" = "source-sql2019" # Change this according to your environment needs
                        "MicrosoftSQLServerSettings_DatabaseName" = "AdventureWorks2016"
                        "MicrosoftSQLServerSettings_Password" = Read-Host "Enter a password:" -AsSecureString
                        "MicrosoftSQLServerSettings_Port" = "1433" # Change this according to your environment needs
                        "MicrosoftSQLServerSettings_ServerName" = "10.0.1.192" # Change this according to your environment needs
                        "MicrosoftSQLServerSettings_Username" = "dms_src_usr" # Change this according to your environment needs
                        "EngineName" = "sqlserver"
                        "EndpointType" = "source"}

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($EndpointSettings.MicrosoftSQLServerSettings_Password)
$EndpointPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

$EndpointStatus = New-DMSEndpoint -EndpointIdentifier $EndpointSettings.EndpointIdentifier -EndpointType $EndpointSettings.EndpointType -EngineName $EndpointSettings.EngineName -MicrosoftSQLServerSettings_DatabaseName $EndpointSettings.MicrosoftSQLServerSettings_DatabaseName -MicrosoftSQLServerSettings_Password $EndpointPassword -MicrosoftSQLServerSettings_Port $EndpointSettings.MicrosoftSQLServerSettings_Port -MicrosoftSQLServerSettings_ServerName $EndpointSettings.MicrosoftSQLServerSettings_ServerName -MicrosoftSQLServerSettings_Username $EndpointSettings.MicrosoftSQLServerSettings_Username

Write-Output "Endpoint Status: $($EndpointStatus.Status)"
