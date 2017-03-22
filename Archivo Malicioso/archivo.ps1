#Monroy Rubio Cristian Alexis
#Comandos utilizados
#Ya jalan los dos :v


$Listener = [System.Net.Sockets.TcpListener]6969;
$Listener.Start();
[byte[]]$bytes = 0..255|%{0}
$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
while($true)
   {
       $bytes[0..($i-1)]|%{$_}
       if ($Echo){$stream.Write($bytes,0,$i)}
   }




#Con este levantaban otro puerto en nishang.
'''
$IPAddress = 127.0.0.1
$Port = 6969
$endpoint = New-Object System.Net.IPEndPoint ([system.net.ipaddress]::any, $Port)
$listener = New-Object System.Net.Sockets.TcpListener $endpoint

#This sets up a local firewall rule to suppress the Windows "Allow Listening Port Prompt"
netsh advfirewall firewall add rule name="PoshRat Server $Port" dir=in action=allow protocol=TCP localport=$Port | Out-Null
$listener.Start()
Write-Output "Listening on $IPAddress`:$Port"
[byte[]]$bytes = 0..255|%{0}
$stream = $IPAddress.GetStream()
while($true)
   {
       $bytes[0..($i-1)]|%{$_}
       if ($Echo){$stream.Write($bytes,0,$i)}
   }
'''

