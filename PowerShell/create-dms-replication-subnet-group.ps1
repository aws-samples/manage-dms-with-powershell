#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$ReplicationSubnetGroupIdentifier = "dms-replication-subnet-group"
$ReplicationSubnetGroupDescription = "DMS Subnet Group"

# The Subnet ID's you want to include as part of the DMS Replication Subnet Group
$AWSSubnets = @("subnet-09b5e1ce9b40edf05", "subnet-065e6e79a2a58ca93")
if (!(Get-DMSReplicationSubnetGroup | Where-Object { $_.ReplicationSubnetGroupIdentifier -eq $ReplicationSubnetGroupIdentifier })) {
        New-DMSReplicationSubnetGroup -ReplicationSubnetGroupIdentifier $ReplicationSubnetGroupIdentifier -ReplicationSubnetGroupDescription $ReplicationSubnetGroupDescription -SubnetId $AWSSubnets
}
