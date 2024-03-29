#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0



# After changes are done, file is re-submitted to the AWS DMS.
# Change this according to your environment
$TaskName = "human-resources-full-load-cdc"

# Change this according to the full task settings file location
$TaskSettingsFile = "C:\Temp\AWS Blog\TaskSettings_20240301_161534.json"
[string]$TaskSettings = Get-Content $TaskSettingsFile

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }


Edit-DMSReplicationTask -ReplicationTaskArn $ReplicationTaskObject.ReplicationTaskArn -ReplicationTaskSetting $TaskSettings | Out-Null
Start-Sleep -Seconds 2

$ReplicationTask = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
While ($ReplicationTask.Status -eq "modifying") {
       $ReplicationTask = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
       Write-Output "Task status: $($ReplicationTask.Status)"
       Start-Sleep -Seconds 5

    }
