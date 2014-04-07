#include "SysUtils.h"
#include "../center/SysCenter.h"

void WriteLog(const char* format, ...)
{
	char buf[1024];
	memset(buf, 0, 1024);

	va_list argptr;
	va_start(argptr, format);

	vsprintf(buf, format, argptr);

	va_end(argptr);

	printf("%s\n", buf);
}

void CalcBufLen(PMsgbuf pBuf)
{
	int len = pBuf->len;
	
	PACKLEN(pBuf, len);
}

SBOOL DoCheckSum(PMsgbuf pBuf)
{
	UINT len = pBuf->len;
	PBYTE buf = (PBYTE)pBuf->payload;
	
	PPackHeader header = (PPackHeader)buf;
	USHORT nCheckSum = header->checkSum;

	header->checkSum = 0;
	
	USHORT checksum = Checksum((USHORT*)buf, len);

	return (nCheckSum == checksum);
}

void CheckSumVal(PMsgbuf pBuf)
{
	UINT len = pBuf->len;
	PBYTE buf = (PBYTE)pBuf->payload;
	
	PPackHeader header = (PPackHeader)buf;	
	header->checkSum = 0;

	USHORT nCheckSum = Checksum((USHORT*)buf, len);
	header->checkSum = nCheckSum;	
}

USHORT Checksum(USHORT* buf, int size) 
{ 
     unsigned long cksum = 0; 
 
     while (size > 1)
	 { 
         cksum += *buf++; 
         size -= sizeof(USHORT); 
     } 
 
     if (size)
	 { 
         cksum += *(UCHAR*)buf; 
	 } 

     cksum = (cksum >> 16) + (cksum & 0xffff);

     cksum += (cksum >>16); 
     
	 return (USHORT)(~cksum); 
}

/*
int CreateServSocket()
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1)
    {
		return -1;
    }
	
    
    string addr = "192.168.1.103"; //g_sysCenter.GetServerAddr();
    
    struct sockaddr_in localaddr;
    bzero(&localaddr, sizeof(localaddr));
    localaddr.sin_family = AF_INET;
    localaddr.sin_port = htons(CLIENT_UDP_PORT);
    
    localaddr.sin_addr.s_addr = inet_addr(addr.c_str());
    bzero(&(localaddr.sin_zero), 8);
    
    //bind(sockfd, (struct sockaddr*)&localaddr, sizeof(localaddr));
    if (-1 == bind(sockfd, (struct sockaddr*)&localaddr, sizeof(localaddr)))
    {
		close(sockfd);
        return -1;
    }
    
    //WriteLog("Client startup main ip address=%s port=%d", addr.c_str(), CLIENT_UDP_PORT);
	
    return sockfd;
}
*/


void InitUserCtrl(PUserCtrl user)
{
	user->userInfo.nUserId = 0;
	user->userInfo.strUserName = "";
	
	user->userInfo.strNickName = "";
	
	user->userInfo.tmLastTime = time(NULL);	
	user->userInfo.strSignature = "";
	user->userInfo.strFileName = "";
	user->userInfo.strFilePath = "";

	user->netStatus.nSeqNum = 0;
	
	user->netStatus.nInetAddr = 0;
	user->netStatus.nInetPort = 0;
	
	user->netStatus.nLocalAddr = 0;
	user->netStatus.nLocalMask = 0;
	user->netStatus.nLocalPort = 0;
	
	user->netStatus.bNatOk = FALSE;
	user->netStatus.lastSend = time(NULL);
}

void InitFriendCtrl(PFriendCtrl pFriend)
{
	pFriend->strRowid = "";
	pFriend->nFriendId = 0;
	pFriend->nUserId = 0;
	pFriend->nFriendUserId = 0;
	pFriend->nGroupId = 0;
	pFriend->strNoteName = "";	
}

void InitFriendGroupCtrl(PFriendGroupCtrl pFriendGroup)
{
	pFriendGroup->strRowid = "";
	pFriendGroup->nGroupId = 0;
	pFriendGroup->nUserId = 0;
	pFriendGroup->strGroupName = "";
}
