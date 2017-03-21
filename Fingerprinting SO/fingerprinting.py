#Monroy Rubio Cristian
#Informacion obtenida de: https://isc.sans.edu/forums/diary/Passive+OS+Fingerprinting+Update/18/

import socket, sys
from struct import *

try:
	s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_TCP)

	while True:
	#####################Header IP
		packet = s.recvfrom(1000)
		packet = packet[0]
		ip_header = packet[0:20]
		iph = unpack('!BBHHHBBH4s4s', ip_header)
		version_ihl = iph[0]
		version = version_ihl >> 4
		ihl = version_ihl & 0xF
		iph_lenght = ihl * 4
		protocl = iph[6]
	

	###########Header TCP
		tcp_header = packet[iph_lenght:iph_lenght+20]
		tcph = unpack('!HHLLBBHHH', tcp_header)
		window_size = tcph[6]
		
		if int(window_size) == 5840 or int(window_size) == 32120:
			print 'Posibles sistemas: Linux 2.2, Linux 2.4 :v\n'
			
		elif int(window_size) == 16384:
			print 'Posibles sistemas: OpenBSD, AIX 4.3, Windows 2000 :v\n'
			
		elif int(window_size) == 65535:
			print 'Es FreeBSD :v\n'
		
		elif int(window_size) == 8760:
			print 'Es Solaris 7 :v\n'
			
		elif int(window_size) == 8192:
			print 'Posibles sistemas: Windows 95, Windows 98 :v\n'
		
		elif int(window_size) == 64240:
			print 'Es windows Xp :v\n'
			
		else:
			print 'Sistema no conocido :,v'
		
		
		#print 'Window size ' + str(window_size) + '\nProtocolo ' + str(protocl) + '\n--------------'
		
		s.close()
except:
	print "Listo :v"
