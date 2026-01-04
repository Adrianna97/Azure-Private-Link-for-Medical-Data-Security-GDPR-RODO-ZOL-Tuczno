<#
.SYNOPSIS
Creates a Private DNS Zone for Blob Storage.

.DESCRIPTION
Creates privatelink.blob.core.windows.net and links it
to vnet-zol to resolve Blob Storage names to private IPs.
#>

param(
    [string]$resourceGroup = "rg-zol-tuczno",
    [string]$location = "westeurope",
    [string]$dnsZoneName = "privatelink.blob.core.windows.net",
    [string]$vnetName = "vnet-zol"
)

Connect-AzAccount

# Create DNS Zone
New-AzPrivateDnsZone -ResourceGroupName $resourceGroup -Name $dnsZoneName -ErrorAction SilentlyContinue

# Link DNS Zone to VNet
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup

New-AzPrivateDnsVirtualNetworkLink `
    -ResourceGroupName $resourceGroup `
    -ZoneName $dnsZoneName `
    -Name "zol-dns-link" `
    -VirtualNetworkId $vnet.Id `
    -EnableRegistration $false
