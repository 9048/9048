import socket
s = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
srvadd=('localhost',10000)
msg = 'This is the msg.'
print "msg sent"
sent = s.sendto(msg,srvadd)
data, server = s.recvfrom(10000)
print data
print "closing socket"
s.close
