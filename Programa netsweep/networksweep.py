#Monroy Rubio Cristian
#Funciones calcula_num_hosts y getHosts  tomadas de: https://sergiob.org/unam/DGSCA/python/ips3.py
#Ejecucion python networksweep.py ip mascara

import subprocess
import os
import sys

def calcula_num_hosts(direccionip,direccionmascara):
	netid=''
	num_hosts=0
	octeto_ip=direccionip.split('.')
	octeto_mascara=direccionmascara.split('.')
	octetos_completos=0
	for actual in octeto_mascara:
		if int(actual)==255:
			netid=netid+octeto_ip[octetos_completos]+'.'
			octetos_completos=octetos_completos+1
			next
		else:
			ceros=8
			for digito in bin(int(octeto_mascara[octetos_completos]))[2:]:
				if digito == '1': ceros = ceros - 1
				else: break
			num_hosts=2**((3-octetos_completos)*8+ceros)-2
			netid=netid+str(int(octeto_ip[octetos_completos]) & int((actual)))
			while octetos_completos<3:
				netid=netid + '.0'
				octetos_completos=octetos_completos+1
			break
	return num_hosts,netid
	
def getHosts(direccionip,direccionmascara):
	ips=[]
	num_hosts,netid=calcula_num_hosts(direccionip,direccionmascara)
	red=netid.split('.')
	while num_hosts>0:
		red[3]=str(int(red[3])+1)
		ips.append(red[0]+'.'+red[1]+'.'+red[2]+'.'+red[3])
		if red[3]=='255':
			if red[2]=='255':
				if red[1]=='255':
					red[0]=str(int(red[0])+1)
					red[1]='0'
					red[2]='0'
					red[3]='0'
				else:
					red[1]=str(int(red[1])+1)
					red[2]='0'
					red[3]='0'
			else:
				red[2]=str(int(red[2])+1)
				red[3]='0'
		num_hosts=num_hosts-1
	return ips


try:
	with open(os.devnull, 'wb') as nsw:
		for n in getHosts(sys.argv[1], sys.argv[2]):
			result = subprocess.Popen(['ping', '-c', '1', n],stdout=nsw,stderr=nsw).wait()
			if not result:
				print n, 'arriba :v'

except KeyboardInterrupt:
	print "\nMe mataste >:v"

