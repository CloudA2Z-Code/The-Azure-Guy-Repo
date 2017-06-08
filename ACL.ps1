
#Logging in first time run this command
Get-AzureAccount

# Getting VM details
Get-AzureVM

# Creating a new Access Control List Configuration
$Acl = New-AzureAclConfig

# Setting Up Variables
$vmname = 'theazureguyvm1'
$svc = 'theazureguyvm19042'


# Adding new Permit rule to configuration stored in $Acl
Set-AzureAclConfig -AddRule -ACL $Acl -Action Permit -RemoteSubnet "172.0.0.0/8" -Order 100 -Description "Permit ACL rule"

# Adding new Deny rule to configuration stored in $Acl
Set-AzureAclConfig -AddRule -ACL $Acl -Action Deny -RemoteSubnet "172.0.0.0/8" -Order 200 -Description "Deny ACL rule"

# Applying the ACL with rules on VM 
Get-AzureVM -ServiceName $svc -name $vmname | Add-AzureEndpoint -Name "Web Acess" -Protocol tcp -LocalPort 80 -PublicPort 80 -ACL $Acl | Update-AzureVM

# Removing the ACL with rules on VM
Get-AzureVM -ServiceName $svc -name $vmname | Remove-AzureAclConfig -EndpointName "Web Acess" | Update-AzureVM


