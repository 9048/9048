import socket
fd = socket.socket(socket.AF_INET, socket.SOCK_DGRAM )
udp_ip = socket.gethostname()
udp_port = 5009
while(True):
    message = raw_input("Message for server: ")
    fd.sendto(message, (udp_ip, udp_port))
    reply = fd.recvfrom(1000)
    print("Server says:%s"%(str(reply[0])))
