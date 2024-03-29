#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$TaskName = "human-resources-full-load-cdc" # Change this according to your environment needs
[string]$TableMapping = Get-Content "C:\Temp\AWS Blog\human_resources_table_list.json" # Change this according to your environment needs
[string]$TaskSettings = Get-Content "C:\Temp\AWS Blog\task_settings.json" # Change this according to your environment needs
$ReplicationInstanceIdentifier = "dms-instance-01" # Change this according to your environment needs
$SourceEndpointName = "source-sql2019" # Change this according to your environment needs
$TargetEndpointName = "target-sql2019" # Change this according to your environment needs


$ReplicationInstanceObject = Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier }
$SourceEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $SourceEndpointName }
$TargetEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $TargetEndpointName }
$MigrationType = "full-load-and-cdc"



$Results = New-DMSReplicationTask -ReplicationInstanceArn $ReplicationInstanceObject.ReplicationInstanceArn -CdcStartPosition $CdcStartPosition  -MigrationType $MigrationType -ReplicationTaskIdentifier $TaskName -ReplicationTaskSetting $TaskSettings -SourceEndpointArn $SourceEndpointObject.EndpointArn -TableMapping $TableMapping -TargetEndpointArn $TargetEndpointObject.EndpointArn
Write-Output "Task Status: $($Results.Status)"


$ReplicationTask = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $Results.ReplicationTaskIdentifier }
Write-Output "Task Status: $($ReplicationTask.Status)"
