#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$RDSInstanceIdentifier = "database-1" # Change to the name of your RDS Instance
(Get-RDSDBInstance -DBInstanceIdentifier $RDSInstanceIdentifier).VpcSecurityGroups
(Get-RDSDBInstance -DBInstanceIdentifier $RDSInstanceIdentifier).Endpoint
