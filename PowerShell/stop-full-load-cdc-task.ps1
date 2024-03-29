#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


$TaskName = "human-resources-full-load-cdc" # Change this according to your environment

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }

$StopTaskStatus = Stop-DMSReplicationTask -ReplicationTaskArn $ReplicationTaskObject.ReplicationTaskArn

while($StopTaskStatus.Status -eq "stopping"){
    $StopTaskStatus = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
    Write-Output "Stopping [$($StopTaskStatus.ReplicationTaskIdentifier)]. Current Status is [$($StopTaskStatus.Status)]"
    Start-Sleep -Seconds 5


}
