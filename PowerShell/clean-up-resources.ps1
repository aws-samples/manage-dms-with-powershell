#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "dbo-full-load-cdc" } | Stop-DMSReplicationTask -Force
Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "human-resources-full-load-cdc" } | Stop-DMSReplicationTask -Force
Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "production-full-load-cdc"}  | Stop-DMSReplicationTask -Force

Start-Sleep -Seconds 30

Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "dbo-full-load-cdc" } | Remove-DMSReplicationTask -Force
Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "human-resources-full-load-cdc" } | Remove-DMSReplicationTask -Force
Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq "production-full-load-cdc"}  | Remove-DMSReplicationTask -Force


# Change this according to your environment
$SourceEndpointName = "source-sql2019"
Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $SourceEndpointName }  | Remove-DMSEndpoint -Force

# Change this according to your environment
$TargetEndpointName = "target-sql2019"
Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $TargetEndpointName }  | Remove-DMSEndpoint -Force



# Change this according to your environment
$ReplicationInstanceIdentifier = "dms-instance-01"
Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier }  | Remove-DMSReplicationInstance -Force


# Change this according to your environment
# You may need to wait for the DMS Replication Instance deletion to complete, before executing this one.
$ReplicationSubnetGroup = "dms-replication-subnet-group"
Get-DMSReplicationSubnetGroup | Where-Object { $_.ReplicationSubnetGroupIdentifier -eq $ReplicationSubnetGroup }  | Remove-DMSReplicationSubnetGroup -Force

