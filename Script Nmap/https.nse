local nmap = require "nmap"
local shortport = require "shortport"
local sslcert = require "sslcert"
local stdnse = require "stdnse"

description = [[
Modo de ejecucion: nmap --script https.nse sitio web

Devuelve la informacion de los certificados en un sitio web, los devuelve de la siguiente manera:

https: 
| Certificado
|   stateOrProvinceName
|   California
|   commonName
|   *.google.com
|   countryName
|   US
|   localityName
|   Mountain View
|   organizationName
|   Google Inc
|   commonName
|   Google Internet Authority G2
|   countryName
|   US
|   organizationName
|   Google Inc
|   PEM
|   -----BEGIN CERTIFICATE-----
|   MIIHJDCCBgygAwIBAgIIMsQxJGqlBO8wDQYJKoZIhvcNAQELBQAwSTELMAkGA1UE
|   BhMCVVMxEzARBgNVBAoTCkdvb2dsZSBJbmMxJTAjBgNVBAMTHEdvb2dsZSBJbnRl
|   cm5ldCBBdXRob3JpdHkgRzIwHhcNMTcwMzE2MDkxNDMxWhcNMTcwNjA4MDg1NDAw
|   WjBmMQswCQYDVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwN
|   TW91bnRhaW4gVmlldzETMBEGA1UECgwKR29vZ2xlIEluYzEVMBMGA1UEAwwMKi5n
|   b29nbGUuY29tMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEcteXt81y2u+Ab7nk
|   /DH1wNQssGiaMadQEyJFARIpkVKMwe5duXLq2DQb9uztHkFXXSSmxLHV1qjES+o/
|   h5wzqqOCBLwwggS4MB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjALBgNV
|   HQ8EBAMCB4AwggN7BgNVHREEggNyMIIDboIMKi5nb29nbGUuY29tgg0qLmFuZHJv
|   aWQuY29tghYqLmFwcGVuZ2luZS5nb29nbGUuY29tghIqLmNsb3VkLmdvb2dsZS5j
|   b22CDiouZ2NwLmd2dDIuY29tghYqLmdvb2dsZS1hbmFseXRpY3MuY29tggsqLmdv
|   b2dsZS5jYYILKi5nb29nbGUuY2yCDiouZ29vZ2xlLmNvLmlugg4qLmdvb2dsZS5j
|   by5qcIIOKi5nb29nbGUuY28udWuCDyouZ29vZ2xlLmNvbS5hcoIPKi5nb29nbGUu
|   Y29tLmF1gg8qLmdvb2dsZS5jb20uYnKCDyouZ29vZ2xlLmNvbS5jb4IPKi5nb29n
|   bGUuY29tLm14gg8qLmdvb2dsZS5jb20udHKCDyouZ29vZ2xlLmNvbS52boILKi5n
|   b29nbGUuZGWCCyouZ29vZ2xlLmVzggsqLmdvb2dsZS5mcoILKi5nb29nbGUuaHWC
|   CyouZ29vZ2xlLml0ggsqLmdvb2dsZS5ubIILKi5nb29nbGUucGyCCyouZ29vZ2xl
|   LnB0ghIqLmdvb2dsZWFkYXBpcy5jb22CDyouZ29vZ2xlYXBpcy5jboIUKi5nb29n
|   bGVjb21tZXJjZS5jb22CESouZ29vZ2xldmlkZW8uY29tggwqLmdzdGF0aWMuY26C
|   DSouZ3N0YXRpYy5jb22CCiouZ3Z0MS5jb22CCiouZ3Z0Mi5jb22CFCoubWV0cmlj
|   LmdzdGF0aWMuY29tggwqLnVyY2hpbi5jb22CECoudXJsLmdvb2dsZS5jb22CFiou
|   eW91dHViZS1ub2Nvb2tpZS5jb22CDSoueW91dHViZS5jb22CFioueW91dHViZWVk
|   dWNhdGlvbi5jb22CCyoueXRpbWcuY29tghphbmRyb2lkLmNsaWVudHMuZ29vZ2xl
|   LmNvbYILYW5kcm9pZC5jb22CG2RldmVsb3Blci5hbmRyb2lkLmdvb2dsZS5jboIE
|   Zy5jb4IGZ29vLmdsghRnb29nbGUtYW5hbHl0aWNzLmNvbYIKZ29vZ2xlLmNvbYIS
|   Z29vZ2xlY29tbWVyY2UuY29tggp1cmNoaW4uY29tggp3d3cuZ29vLmdsggh5b3V0
|   dS5iZYILeW91dHViZS5jb22CFHlvdXR1YmVlZHVjYXRpb24uY29tMGgGCCsGAQUF
|   BwEBBFwwWjArBggrBgEFBQcwAoYfaHR0cDovL3BraS5nb29nbGUuY29tL0dJQUcy
|   LmNydDArBggrBgEFBQcwAYYfaHR0cDovL2NsaWVudHMxLmdvb2dsZS5jb20vb2Nz
|   cDAdBgNVHQ4EFgQU4mHt6VQtlZeHon8lsro0iTWIamowDAYDVR0TAQH/BAIwADAf
|   BgNVHSMEGDAWgBRK3QYWG7z2aLV29YG2u2IaulqBLzAhBgNVHSAEGjAYMAwGCisG
|   AQQB1nkCBQEwCAYGZ4EMAQICMDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9wa2ku
|   Z29vZ2xlLmNvbS9HSUFHMi5jcmwwDQYJKoZIhvcNAQELBQADggEBAB61Pr+6Gh5N
|   HMdNBAR03HeN0zwZgF11SumW2+FpDfWZ4cFfw7ama/ejYjaImAjWAEa7PxPJ17cw
|   ub7rnOhmzruCIPMBWuvEthIB1Ajyeog8DbJUw34yWCdn1x5ssGduo9tqsM6JfLbg
|   baOWVJaBQ9HMtTfQiwmraifGTpzgzvoyEzx2IUmBFZQnKocOrYUYezRxDvNKMiVP
|   ksUxwzWCl2rNYfYvZs7csWQHJk7AGIfkyoYzDUWoyFjZFt19NG5269EdyISvjZcY
|   tGsk/qXFE14fTepcr3whDPzD3q36iO1dILyC8tL1FL/SAgfu2pJ196loNZYQ+Yt6
|   7xrbc8Hv56Q=
|   -----END CERTIFICATE-----
|   Public Key Type
|   ec
|   Public Key Bits
|   MD5
|   1658079360e334c89432d9f84da8cea3
|   SHA-1
|   2d118af253b9ea95c99268d341caf56d18b0bdcb
|   2017-03-16T08:14:31+00:00
|_  2017-06-08T07:54:00+00:00
]]

author = "Monroy Rubio Cristian"

license = "http://nmap.org/book/man-legal.html"

categories = { "default", "safe", "discovery" }


portrule = function(host, port)
  return shortport.ssl(host, port) or sslcert.isPortSupported(port)
end

action = function(host, port)
  local status, cert = sslcert.getCertificate(host, port)
  local certificados = {}
  certificados['name'] = "Certificado"
  
  for k,v in pairs(cert.subject) do
	table.insert(certificados, k)
	table.insert(certificados, v)
  end
  
  for k,v in pairs(cert.issuer) do
	table.insert(certificados, k)
	table.insert(certificados, v)
  end
  
  table.insert(certificados, 'PEM')
  table.insert(certificados, cert.pem)  
  
  table.insert(certificados, 'Public Key Type')
  table.insert(certificados, cert.pubkey.type)  
  
  table.insert(certificados, 'Public Key Bits')
  table.insert(certificados, cert.pubkey.bits)  
  
  table.insert(certificados, 'MD5')
  table.insert(certificados, stdnse.tohex(cert:digest("md5")))
  
  table.insert(certificados, 'SHA-1')
  table.insert(certificados, stdnse.tohex(cert:digest("sha1")))
  
  
  for k, v in pairs(cert.validity) do
    if type(v)=="string" then
      k = v
      table.insert(certificados, v)
    else
      k = stdnse.format_timestamp(stdnse.date_to_timestamp(v, 0), 0)
      table.insert(certificados, k)
    end
  end  
  return stdnse.format_output(true,certificados)
end





