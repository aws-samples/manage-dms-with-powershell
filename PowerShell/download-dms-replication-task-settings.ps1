#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0



# File is downloaded to local workstation
# Changes performed on the Task Settings file
$TaskName = "human-resources-full-load-cdc" # Change this according to your environment
$FolderToSave = "C:\Temp\AWS Blog" # Change this according to your environment needs

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }


$FullPath = -join($FolderToSave,"\TaskSettings_",(Get-Date -Format "yyyyMMdd_HHmmss"),".json")
Write-Output "Saving the file at: $FullPath"
$ReplicationTaskObject.ReplicationTaskSettings | Out-File $FullPath
