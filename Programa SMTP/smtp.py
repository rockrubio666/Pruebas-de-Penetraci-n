#Monroy Rubio Cristian Alexis
#Ejecucion python smtp.py archivo

import socket, select, sys,re
host = 'Colocar ip'
# Ejemplo :v :'193.170.100.190' 
port = 25

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(30)

try:
	s.connect((host,port))
except:
	print 'No conectado'
	sys.exit()

print "Conectando.... :v :v"

while 1:
    socket_list = [sys.stdin, s]
    read_sockets,write_sockets,error_sockets = select.select(socket_list, [], [])

    for sock in read_sockets:
        if sock == s:
            data = sock.recv(4096)
        
            users = open(sys.argv[1],'r')
            for username in users:
                chain = 'VRFY ' + username 
                log = s.sendall(chain)	
	
                if log:
                    print "Error"
                else:
                    try:
                        data = s.recv(4096)
                    except socket.timeout:
                        print "Fuera de tiempo"
	
                if data:
                    if re.search(r'2[0-9][0-9]',data):
                        print "Usuario valido " + data
                    else:
                        print "Es un usuario no valido :,v ", username				
        else:
			msg = sys.stdin.readline()
			s.send(msg)	
s.close()
	
	
