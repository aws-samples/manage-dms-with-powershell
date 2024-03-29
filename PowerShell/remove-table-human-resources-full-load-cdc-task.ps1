#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


# First part of the script
# File is downloaded to local workstation
# Changes performed on the Table Mappings file
$TaskName = "human-resources-full-load-cdc" # Change this according to your environment
$FolderToSave = "C:\Temp\AWS Blog" # Change this according to your needs

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }

$FullPath = -join($FolderToSave,"\TableMappings_",(Get-Date -Format "yyyyMMdd_HHmmss"),".json")
Write-Output "Saving the file at: $FullPath"
$ReplicationTaskObject.TableMappings | Out-File $FullPath


# Second part of the script
# After changes are done, file is re-submitted to the AWS DMS.
$TaskName = "human-resources-full-load-cdc" # Change this according to your environment

[string]$TableMappings = Get-Content $FullPath

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }


Edit-DMSReplicationTask -ReplicationTaskArn $ReplicationTaskObject.ReplicationTaskArn -TableMapping $TableMappings | Out-Null
Start-Sleep -Seconds 2

$ReplicationTask = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
While ($ReplicationTask.Status -eq "modifying") {
       $ReplicationTask = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
       Write-Output "Task status: $($ReplicationTask.Status)"
       Start-Sleep -Seconds 5

    }
