#include "SysSock.h"

#include <arpa/inet.h>
#include <sys/socket.h>

#include "../include/Sysdefine.h"

int CreateServSocket(string addr)
{
	int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1)   
    {   
		return -1;   
    } 
	
    struct sockaddr_in localaddr;
    bzero(&localaddr, sizeof(localaddr));
    localaddr.sin_family = AF_INET;
    localaddr.sin_port = htons(CLIENT_UDP_PORT);

    localaddr.sin_addr.s_addr = inet_addr(addr.c_str());
    bzero(&(localaddr.sin_zero), 8);

    if (-1 == bind(sockfd, (struct sockaddr*)&localaddr, sizeof(localaddr)))
    {
		shutdown(sockfd, SHUT_RDWR);
        return -1;
    }    
	
	return sockfd;
}
