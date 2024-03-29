#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

# This is a continuation of file: retrieve-rds-security-groups.ps1

$RDSSecurityGroupId = "TargetRDSSecGroupId" # Change this according to your environment
(Get-EC2SecurityGroup -GroupId $RDSSecurityGroupId).IpPermissions.UserIdGroupPairs
