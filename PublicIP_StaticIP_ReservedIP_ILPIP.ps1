ping theazureguyvm1.cloudapp.net
ping theazureguyvm2.cloudapp.net

#Logging in first time run this command
Get-AzureAccount

#Select subscription if u have multiple subscriptions
Select-AzureSubscription

# Prerequisite: VNet has been set up with SubNet
# Set-AzureVNetConfig -ConfigurationPath $vnetConfigPath;

# Setting Internal IP to static 
$vmname = 'theazureguyvm2'
$svc = 'theazureguyvm2'
$ip = '10.0.0.4'
$vm = Get-AzureVM -ServiceName $svc

Set-AzureStaticVNetIP -IPAddress $ip -VM $vm | Update-AzureVM


# Removing Internal IP back to Dynamic  
$vmname = 'theazureguyvm2'
$svc = 'theazureguyvm2'
$ip = '10.0.0.4'
$vm = Get-AzureVM -ServiceName $svc

Remove-AzureStaticVNetIP -VM $vm | Update-AzureVM



#Reserved IP is set at subscription level, first opt for REserve IP and then assign create a new deployment

# Get a Reserved IP inorder to assign any of your cloud services  
New-AzureReservedIP –ReservedIPName TheAzureGuyVM1RIP –Location “Southeast Asia”

Get-AzureReservedIP

#Release a Reserved IP , if not it costs
Remove-AzureReservedIP –ReservedIPName TheAzureGuyVM1RIP



#Instance Level Public IP 
$vmname = 'theazureguyvm1'
$svc = 'TheAzureGuyVM16066'
$vm = Get-AzureVM -ServiceName $svc

$vm | Set-AzurePublicIP -PublicIPName TheAzureGuyVM1PIP | Update-AzureVM




