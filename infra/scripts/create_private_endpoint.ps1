<#
.SYNOPSIS
Creates a Private Endpoint for Blob Storage.

.DESCRIPTION
Creates a Private Endpoint that exposes Blob Storage only
through a private IP address inside vnet-zol/subnet-it.
#>

param(
    [string]$resourceGroup = "rg-zol-tuczno",
    [string]$location = "westeurope",
    [string]$storageName = "zolstorage",
    [string]$vnetName = "vnet-zol",
    [string]$subnetName = "subnet-it",
    [string]$peName = "pe-blob-zol"
)

Connect-AzAccount

# Get VNet and subnet
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet

# Create Private Endpoint
New-AzPrivateEndpoint `
    -Name $peName `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -Subnet $subnet `
    -PrivateLinkServiceConnection @(
        New-AzPrivateLinkServiceConnection `
            -Name "blobConnection" `
            -PrivateLinkServiceId "/subscriptions/$((Get-AzContext).Subscription.Id)/resourceGroups/$resourceGroup/providers/Microsoft.Storage/storageAccounts/$storageName" `
            -GroupId "blob"
    )
