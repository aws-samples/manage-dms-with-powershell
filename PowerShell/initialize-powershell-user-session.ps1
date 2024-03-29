#
# // Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# // SPDX-License-Identifier: MIT-0


# First, list all the profiles you have available in the PowerShell console and select the one you want to use.
Get-AWSCredentials -ListProfileDetail


$ProfileName = "NameOfProfile" # This should be retrieved from the above command.
$RegionId = "NameOfProfile" # Region code used when creating the PowerShell profile.

Initialize-AWSDefaultConfiguration -ProfileName $ProfileName -Region $RegionId
