#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$ReplicationInstanceIdentifier = "dms-instance-01" # Change this according to your environment

$LogGroupName = -join('dms-tasks-',$ReplicationInstanceIdentifier)
Get-CWLLogGroup -LogGroupNamePrefix $LogGroupName


