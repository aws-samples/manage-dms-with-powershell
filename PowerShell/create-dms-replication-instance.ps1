#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

# Change this according to your environment needs
$ReplicationInstanceIdentifier = "dms-instance-01"
# This is the Replication Subnet Group created in the previous section
$ReplicationSubnetGroupIdentifier = "dms-replication-subnet-group"
# This is the Security Group created in the previous section
$VpcSecurityGroupId = "sg-0f57d952a8ec41412"
# Change this according to your environment
$ResourceIdentifier = "dms-instance-01"
$ReplicationInstanceClass = "dms.r5.large"
$AllocatedStorage = 50
$EngineVersion = "3.5.2"


$DMSInstanceObject = New-DMSReplicationInstance -ReplicationInstanceIdentifier $ReplicationInstanceIdentifier -ReplicationSubnetGroupIdentifier $ReplicationSubnetGroupIdentifier -VpcSecurityGroupId $VpcSecurityGroupId -ResourceIdentifier $ResourceIdentifier -ReplicationInstanceClass $ReplicationInstanceClass -AllocatedStorage $AllocatedStorage -EngineVersion $EngineVersion

While ($DMSInstanceObject.ReplicationInstanceStatus -eq "creating") {

            $DMSInstanceObject = Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier }
            Write-Output "DMS Instance creation status: $($DMSInstanceObject.ReplicationInstanceStatus)"
            Start-Sleep -Seconds 10

}
