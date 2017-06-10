

#Logging in first time run this command
Get-AzureAccount

#NSG-FrontEnd
#Create a network security group named NSG-FrontEnd.
New-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" -Location "Southeast Asia" -Label "Front end subnet NSG"

#rdp-rule
#Create a security rule allowing access from the Internet to port 3389.
Get-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" | Set-AzureNetworkSecurityRule -Name rdp-rule -Action Allow -Protocol TCP -Type Inbound -Priority 100  -SourceAddressPrefix Internet  -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange '3389'

#web-rule
#Create a security rule allowing access from the Internet to port 80.
Get-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" | Set-AzureNetworkSecurityRule -Name web-rule -Action Allow -Protocol TCP -Type Inbound -Priority 200  -SourceAddressPrefix Internet  -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange '80'


#NSG-BackEnd
New-AzureNetworkSecurityGroup -Name "NSG-BackEnd" -Location "Southeast Asia" -Label "Back end subnet NSG"

#sql-rule
Get-AzureNetworkSecurityGroup -Name "NSG-FrontEnd" | Set-AzureNetworkSecurityRule -Name rdp-rule-frm-backend -Action Allow -Protocol TCP -Type Inbound -Priority 300 -SourceAddressPrefix 192.168.1.0/24  -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange '1433'

#web-rule
Get-AzureNetworkSecurityGroup -Name "NSG-BackEnd" | Set-AzureNetworkSecurityRule -Name block-internet -Action Deny -Protocol '*' -Type Outbound -Priority 200 -SourceAddressPrefix '*'  -SourcePortRange '*' -DestinationAddressPrefix Internet -DestinationPortRange '*'

#GET NSG Details 
Get-AzureNetworkSecurityGroup -Name "NSG-BackEnd" –Detailed
