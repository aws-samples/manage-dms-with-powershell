#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


[string]$TableMapping = Get-Content "C:\Temp\AWS Blog\production_table_list.json" # Change this according to your environment
[string]$TaskSettings = Get-Content "C:\Temp\AWS Blog\task_settings.json" # Change this according to your environment
$ReplicationInstanceIdentifier = "dms-instance-01" # Change this according to your environment
$SourceEndpointName = "source-sql2019" # Change this according to your environment
$TargetEndpointName = "target-sql2019" # Change this according to your environment
$TaskName = "production-full-load-cdc" # Change this according to your environment


$ReplicationInstanceObject = Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier }
$SourceEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $SourceEndpointName }
$TargetEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $TargetEndpointName }
$MigrationType = "full-load-and-cdc"


$NewDMSTaskResult = New-DMSReplicationTask -ReplicationInstanceArn $ReplicationInstanceObject.ReplicationInstanceArn -CdcStartPosition $CdcStartPosition  -MigrationType $MigrationType -ReplicationTaskIdentifier $TaskName -ReplicationTaskSetting $TaskSettings -SourceEndpointArn $SourceEndpointObject.EndpointArn -TableMapping $TableMapping -TargetEndpointArn $TargetEndpointObject.EndpointArn
Write-Output "Task Status: $($Results.Status)"
while($NewDMSTaskResult.Status -eq "creating"){

        $NewDMSTaskResult = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
        Write-Output "Task Status: $($NewDMSTaskResult.Status)"
        Start-Sleep -Seconds 5

}
