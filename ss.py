import socket
udp_ip = socket.gethostname()
udp_port = 5009
fd = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
fd.bind((udp_ip,udp_port))
while True:
    r = fd.recvfrom(1000)
    print("client says: %s"%(str(r[0])))
    reply = raw_input("Message for client: ")
    client_address = r[1]
    fd.sendto(reply, client_address)
