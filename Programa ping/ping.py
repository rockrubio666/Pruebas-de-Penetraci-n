#Monroy Rubio Cristian Alexis
#Informacion obtenida de: www.kellyodonnell.com/content/determining-os-type-ping

import os
import sys
import subprocess
import re

hostname = str(sys.argv[1])
cmd = ['ping', '-c 1', hostname]
with open('output.txt','w') as out:
	return_code = subprocess.call(cmd,stdout=out)

ttl = open('output.txt',"r")
for line in ttl:
	ttl1 = re.search(r'ttl=[0-9]{1,3}',line)
	if ttl1:
		algo = ttl1.group()
		a,b=algo.split('=')
		
		if  30 < int(b) > 40:
			print( 'Posibles sistemas: AIX, DEC Pathworks,HP-UX,OSF/1,Stratus,Ultrix,VMS/Wollongong\n')
		elif 50 < int(b) > 70:
			print( 'Posibles sistemas: AIX,Compa,FreeBSD,HP-UX,Irix,Linux,MACOS,OpenBSD,Solaris,Stratus,SunOS,Ultrix,VMS\Multinet\n')
		elif 100 < int(b) > 140:
			print( 'Posibles sistemas: VMS/Wollongong,VMS/UCX, Windows Server, 98,2003, XP, Vista, 7, 10\n')   
		elif 240 < int(b) > 255:
			print('Posibles sistemas: AIX,BSDI,FreeBSD,Irix,Linux,NetBSD,Solaris\n')
		else:
			print 'No hubo calsificacion'

ttl.close()
