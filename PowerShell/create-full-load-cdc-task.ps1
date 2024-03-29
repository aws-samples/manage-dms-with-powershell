#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0

$LocalFolder = "C:\Temp\AWS Blog"
$Files = @("dbo-full-load-cdc.json", "human-resources-full-load-cdc.json", "production-full-load-cdc.json")

# Change this according to your environment
$TaskSettingsFile = Join-Path -Path $LocalFolder -ChildPath "task-settings.json"
[string]$TaskSettings = Get-Content -Path $TaskSettingsFile

# Change this according to your environment
$ReplicationInstanceIdentifier = "dms-instance-01"

# Change this according to your environment
$SourceEndpointName = "source-sql2019"

# Change this according to your environment
$TargetEndpointName = "target-sql2019"


$ReplicationInstanceObject = Get-DMSReplicationInstance | Where-Object { $_.ReplicationInstanceIdentifier -eq $ReplicationInstanceIdentifier }
$SourceEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $SourceEndpointName }
$TargetEndpointObject = Get-DMSEndpoint | Where-Object { $_.EndpointIdentifier -eq $TargetEndpointName }
$MigrationType = "full-load-and-cdc"

foreach ($file in $Files) {
        $filename = Join-Path -Path $LocalFolder -ChildPath $file
        $TaskName = $file.split(".")[0]
        Write-Output "Working to create [$file]"

        # Change this according to your environment
        [string]$TableMapping = Get-Content $filename

        $NewDMSTaskResult = New-DMSReplicationTask -ReplicationInstanceArn $ReplicationInstanceObject.ReplicationInstanceArn -CdcStartPosition $CdcStartPosition  -MigrationType $MigrationType -ReplicationTaskIdentifier $TaskName -ReplicationTaskSetting $TaskSettings -SourceEndpointArn $SourceEndpointObject.EndpointArn -TableMapping $TableMapping -TargetEndpointArn $TargetEndpointObject.EndpointArn
        while ($NewDMSTaskResult.Status -eq "creating") {

                $NewDMSTaskResult = Get-DMSReplicationTask | Where-Object { $_.ReplicationTaskIdentifier -eq $TaskName }
                Write-Output "Task Status: $($NewDMSTaskResult.Status)"
                Start-Sleep -Seconds 10

        }

}
