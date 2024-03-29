#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


$ReplicationInstanceIdentifier = "dms-instance-01" # Change this according to your environment needs
$RDSInstanceIdentifier = "database-1" # Change according to your environment if needed
$RDSSecurityGroupId = "sg-0a7f47c256606e4d6" # Provide Security Group ID for your RDS Instance
$TCPPort = (Get-RDSDBInstance -DBInstanceIdentifier $RDSInstanceIdentifier).Endpoint.Port
$DMSSecurityGroupId = (Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier}).VpcSecurityGroups.VpcSecurityGroupId

$InboundRule = New-Object Amazon.EC2.Model.IpPermission
$UserIdGroupPair = New-Object Amazon.EC2.Model.UserIdGroupPair

$InboundRule.FromPort = $TCPPort
$InboundRule.ToPort = $TCPPort
$InboundRule.IpProtocol = "tcp"

$UserIdGroupPair.Description = "TCP Port to be used by DMS to access RDS for SQL Server"
$UserIdGroupPair.GroupId = $DMSSecurityGroupId
$InboundRule.UserIdGroupPair = $UserIdGroupPair

Grant-EC2SecurityGroupIngress -GroupId $RDSSecurityGroupId -IpPermission $InboundRule


(Get-EC2SecurityGroup -GroupId $RDSSecurityGroupId).IpPermissions.UserIdGroupPairs