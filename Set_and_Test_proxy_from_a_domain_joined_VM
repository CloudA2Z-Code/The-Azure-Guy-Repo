$Username="******"
$Password="********"
$WebProxy = New-Object System.Net.WebProxy("http://nl-proxy-access.net.abnamro.com:8080",$true)
$url="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"
$WebClient = New-Object net.webclient
$WebClient.Proxy=$webproxy
$WebClient.proxy.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
$path="C:\Users"
$webClient.DownloadFileAsync("https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png","googlelogo_color_272x92dp.png")
