#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$ReplicationInstanceIdentifier = "dms-instance-01" # This should be changed according to your environment needs
$SourceEndpointIdentifier = "source-sql2019" # This should be changed according to your environment needs
$TargetEndpointIdentifier = "target-sql2019" # This should be changed according to your environment needs

$DMSInstanceObject = Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier}

$SourceEndpointDimension = New-Object Amazon.DatabaseMigrationService.Model.Filter
$SourceEndpointObject = Get-DMSEndpoint | Where-Object {$_.EndpointIdentifier -eq $SourceEndpointIdentifier}
$SourceEndpointDimension.Name = 'endpoint-arn'
$SourceEndpointDimension.Values = $SourceEndpointObject.EndpointArn

$TargetEndpointDimension = New-Object Amazon.DatabaseMigrationService.Model.Filter
$TargetEndpointObject =  Get-DMSEndpoint | Where-Object {$_.EndpointIdentifier -eq $TargetEndpointIdentifier}
$TargetEndpointDimension.Name = 'endpoint-arn'
$TargetEndpointDimension.Values = $TargetEndpointObject.EndpointArn


$DMSConnectionTestStatus = Test-DMSConnection -EndpointArn $SourceEndpointObject.EndpointArn -ReplicationInstanceArn $DMSInstanceObject.ReplicationInstanceArn
Write-Output "Testing DMS Endpoint connection for: [$($DMSConnectionTestStatus.EndpointIdentifier)]"
while($DMSConnectionTestStatus.Status -eq "testing"){
       $DMSConnectionTestStatus = Get-DMSConnection -Filter $SourceEndpointDimension | Where-Object {$_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier}
       Write-Output "DMS Test Connection status: $($DMSConnectionTestStatus.Status)"
       Start-Sleep -Seconds 5

}
if($null -eq $($DMSConnectionTestStatus.LastFailureMessage)){
       Write-Output "DMS Test Connection Message: $($DMSConnectionTestStatus.Status)"
}
else{
Write-Output "DMS Test Connection Message: $($DMSConnectionTestStatus.LastFailureMessage)"
}


$DMSConnectionTestStatus = Test-DMSConnection -EndpointArn $TargetEndpointObject.EndpointArn -ReplicationInstanceArn $DMSInstanceObject.ReplicationInstanceArn
Write-Output "Testing DMS Endpoint connection for: [$($DMSConnectionTestStatus.EndpointIdentifier)]"
while($DMSConnectionTestStatus.Status -eq "testing"){
       $DMSConnectionTestStatus = Get-DMSConnection -Filter $TargetEndpointDimension | Where-Object {$_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier}
       Write-Output "DMS Test Connection status: $($DMSConnectionTestStatus.Status)"
       Start-Sleep -Seconds 5

}
if($null -eq $($DMSConnectionTestStatus.LastFailureMessage)){
       Write-Output "DMS Test Connection Message: $($DMSConnectionTestStatus.Status)"
}
else{
Write-Output "DMS Test Connection Message: $($DMSConnectionTestStatus.LastFailureMessage)"
}
