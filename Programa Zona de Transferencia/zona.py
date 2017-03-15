#Monroy Rubio Cristian

import sys
import dns.resolver
import subprocess
import shlex


archivo = str(sys.argv[1])
domains = open(archivo, 'r').read().splitlines()

for line in domains:
	
	ns = dns.resolver.query(line,'NS')
	
	for i in ns.response.answer:
		for j in i.items:
			cmd = 'dig axfr @' + str(j) + ' ' + line
			proc=subprocess.Popen(shlex.split(cmd),stdout=subprocess.PIPE)
			out=proc.communicate()
			a,b = out
			print a



