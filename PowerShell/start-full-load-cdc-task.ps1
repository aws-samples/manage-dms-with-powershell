#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$Files = @("dbo-full-load-cdc", "human-resources-full-load-cdc", "production-full-load-cdc")

foreach ($file in $Files) {
    $TaskName = $file.split(".")[0]
    Write-Output "Starting task [$TaskName]"

    $ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }

    $StartTaskStatus = Start-DMSReplicationTask -ReplicationTaskArn $ReplicationTaskObject.ReplicationTaskArn -StartReplicationTaskType start-replication
    Start-Sleep -Seconds 5
    Write-Output "Starting [$($StartTaskStatus.ReplicationTaskIdentifier)]. Current Status is [$($StartTaskStatus.Status)]"

}
