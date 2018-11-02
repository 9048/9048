import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
srvadd=('localhost',10000)
print 'starting on',srvadd
s.bind(srvadd)
while True:
 print "wating for msg"
 data, address = s.recvfrom(10000)
 print "recieved",len(data),"bytes from",address
 print data
 if data:
  sent=s.sendto(data,address)
  print "sent",sent,"bytes back to",address
