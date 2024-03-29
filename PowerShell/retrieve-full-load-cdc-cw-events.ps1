#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


$ReplicationInstanceIdentifier = "dms-instance-01" # Change this according to your environment
$TaskName = "human-resources-full-load-cdc" # Change this according to your environment

$ReplicationTaskObject = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
$LogGroupName = -join('dms-tasks-',$ReplicationInstanceIdentifier)

$LogStreamName = -join('dms-task-',$ReplicationTaskObject.ReplicationTaskArn.Split(":")[6])

$FilterPattern = '"]E:"'
$Data = Get-CWLFilteredLogEvent -LogStreamName $LogStreamName -LogGroupName $LogGroupName -FilterPattern $FilterPattern

$Data.Events




