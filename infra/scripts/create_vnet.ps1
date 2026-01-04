<#
.SYNOPSIS
Creates a Virtual Network and subnet for Private Endpoint.

.DESCRIPTION
Creates VNet vnet-zol and subnet subnet-it, which hosts
the Private Endpoint and internal workloads.
#>

param(
    [string]$resourceGroup = "rg-zol-tuczno",
    [string]$location = "westeurope",
    [string]$vnetName = "vnet-zol",
    [string]$subnetName = "subnet-it",
    [string]$vnetPrefix = "10.1.0.0/16",
    [string]$subnetPrefix = "10.1.2.0/24"
)

Connect-AzAccount

# Create VNet with subnet
New-AzVirtualNetwork `
    -Name $vnetName `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -AddressPrefix $vnetPrefix `
    -Subnet @{"Name"=$subnetName; "AddressPrefix"=$subnetPrefix}
