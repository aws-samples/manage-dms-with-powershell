#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

# Change this according to your environment needs
$SecurityGroupName = "dms-sec-group" 
$Description = "Security Group for AWS DMS"
# Vpc Id where you want to deploy your DMS resources. Change according to your environment needs.
$VpcId = "vpc-0fe44eb01203a54bb" 

New-EC2SecurityGroup -GroupName $SecurityGroupName -Description $Description -VpcId $VpcId
