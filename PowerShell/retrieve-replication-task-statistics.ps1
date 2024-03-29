#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$Tasks = @("dbo-full-load-cdc", "human-resources-full-load-cdc", "production-full-load-cdc")

foreach ($task in $Tasks) {
$TaskStatus = (Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $task}).Status
$TaskStatistics = (Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $task}).ReplicationTaskStats

Write-Output "[$task] current status: $TaskStatus"
Write-Output "Task statistics:`n Tables Loaded: $($TaskStatistics.TablesLoaded)`n Tables Loading: $($TaskStatistics.TablesLoading)`n Tables Errored: $($TaskStatistics.TablesErrored)"

}