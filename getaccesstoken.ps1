# personal azure account , TestAzPricing application in AAD
# key1 = Hpn3J1bshCz3r********hAqO4N6iEM=

Get-AzureRmSubscription

$tenID = "1ae95b5c*********0fa61b1b"
$SubId = "86a78f1***********2073bb71"
$AppID = "57343cd*************2ea43e76"
$pass = "Hpn3J1b*************shAqO4N6iEM="

#1st step is to connect using a Service principle :
#  Connect-AzureRmAccount -Subscription $SubId  -ServicePrincipal -CertificateThumbprint 'xxxxxxxxxxxxxxxxxxxxxxxx' -TenantId $tenID  ( we used a cert to connect)  
#Igor code to get Access token :

#region Get Access Token #
#
# Setting variables values for ApplicationID and Application Key Secret 
#
$tennantid        = $tenID 
$SubscriptionId   = $SubId
$ApplicationID    = $AppID 
$ApplicationKey   = $pass
$TokenEndpoint = {https://login.windows.net/{0}/oauth2/token} -f $tennantid 
$ARMResource = "https://management.core.windows.net/";

$Body = @{
        'resource'= $ARMResource
        'client_id' = $ApplicationID
        'grant_type' = 'client_credentials'
        'client_secret' = $ApplicationKey
}

$params = @{
    ContentType = 'application/x-www-form-urlencoded'
    Headers = @{'accept'='application/json'}
    Body = $Body
    Method = 'Post'
    URI = $TokenEndpoint
}

$token = Invoke-RestMethod @params
# Show the raw token and expiration date converted in readable format: #
$token | select *, @{L='Expires';E={[timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($_.expires_on))}} | fl *

#endregion
