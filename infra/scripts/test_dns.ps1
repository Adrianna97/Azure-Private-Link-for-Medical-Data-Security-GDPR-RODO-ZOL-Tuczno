<#
.SYNOPSIS
Tests DNS resolution for Blob Storage via Private Link.

.DESCRIPTION
Runs nslookup against the Blob Storage endpoint to verify
that the name resolves to a private IP address.
#>

param(
    [string]$storageName = "zolstorage"
)

$fqdn = "$storageName.blob.core.windows.net"

Write-Host "Testing DNS resolution for $fqdn..."
nslookup $fqdn

