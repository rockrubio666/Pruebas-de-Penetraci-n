#Monroy Rubio Cristian
#Ejecucion: python escaer.py ip inicio fin

import socket
import sys
from datetime import datetime

ip = str(sys.argv[1])
inf = int(sys.argv[2])
sup = int(sys.argv[3])

t1 = datetime.now()

try:
	if(int(inf) > 0 and int(sup) <= 65535):
		for port in range(inf,sup):	
			sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
			result = sock.connect_ex((ip,port))
			if result==0:
				print "Port{}	Open".format(port)
			sock.close()
	else:
		print "Rango no valido"
		
except :
	print "No se establecio conexion"
	sys.exit()
	
t2 = datetime.now()
total = t2-t1

print 'Tiempo del escaneo:',total

