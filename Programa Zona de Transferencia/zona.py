#Monroy Rubio Cristian

import sys
import dns.resolver
import subprocess
import shlex


#archivo = str(sys.argv[1])
#ns = dns.resolver.query("ole.com.ar",'NS')
ns = dns.resolver.query("google.com",'NS')


for i in ns.response.answer:
	
	for j in i.items:
		cmd = 'dig axfr @' + str(j) + ' ole.com.ar'
		proc=subprocess.Popen(shlex.split(cmd),stdout=subprocess.PIPE)
		out=proc.communicate()
		a,b = out
		#print a


