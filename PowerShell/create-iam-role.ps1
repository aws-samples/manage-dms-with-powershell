#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


[string]$dmsAssumeRolePolicyDocument = '{
    "Version": "2012-10-17",
    "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
         "Service": "dms.amazonaws.com"
      },
    "Action": "sts:AssumeRole"
    }
  ]
 }'

try{
$DMSVpcRoleName = "dms-vpc-role"

New-IAMRole -RoleName $DMSVpcRoleName -AssumeRolePolicyDocument $dmsAssumeRolePolicyDocument
Start-Sleep -Seconds 5

Register-IAMRolePolicy -RoleName $DMSVpcRoleName -PolicyArn "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
}
catch {

Write-Error $_

}

try{
$DMSCloudWatchRoleName = "dms-cloudwatch-logs-role"

   New-IAMRole -RoleName $DMSCloudWatchRoleName -AssumeRolePolicyDocument $dmsAssumeRolePolicyDocument

    Start-Sleep -Seconds 5
    Register-IAMRolePolicy -RoleName $DMSCloudWatchRoleName -PolicyArn "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
}
catch {

Write-Error $_

}
