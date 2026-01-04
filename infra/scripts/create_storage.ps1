<#
.SYNOPSIS
Creates a Storage Account for medical data (ZOL Tuczno).

.DESCRIPTION
Creates a resource group and a secure Azure Storage Account
used for storing medical documentation. This account will later
be connected to a Private Endpoint for GDPR‑compliant access.
#>

param(
    [string]$resourceGroup = "rg-zol-tuczno",
    [string]$location = "westeurope",
    [string]$storageName = "zolstorage"
)

# Login
Connect-AzAccount

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location -ErrorAction SilentlyContinue

# Create Storage Account
New-AzStorageAccount `
    -ResourceGroupName $resourceGroup `
    -Name $storageName `
    -Location $location `
    -SkuName Standard_LRS `
    -Kind StorageV2 `
    -EnableHttpsTrafficOnly $true `
    -AllowBlobPublicAccess $false `
    -MinimumTlsVersion TLS1_2
