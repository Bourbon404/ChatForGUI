// SendThread.cpp: implementation of the CSendThread class.
//
//////////////////////////////////////////////////////////////////////

#include "SendThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSendThread::CSendThread(int sockfd)
{
	m_sockfd = sockfd;
	m_strThreadName = SENDCTRL;
}
 
CSendThread::~CSendThread()
{

}

SBOOL CSendThread::DoBusiness(PMsgbuf pBuf)
{   
	char* buf = (char*)pBuf->payload;
	buf += pBuf->ptr;

	int size = pBuf->len - pBuf->ptr;

//	pBuf->peer.sin_family = AF_INET;
//	pBuf->peer.sin_port = htons(4080);
//	pBuf->peer.sin_addr.s_addr = inet_addr("192.168.1.100");

//	WriteLog("send msg buf");
	socklen_t addrlen = sizeof(struct sockaddr_in);
	int nSend = sendto(m_sockfd, buf, size, 0, (struct sockaddr*)&(pBuf->peer), addrlen);
	if (nSend == -1)
	{
		UINT nCmdId = 0;
		PARSECMD(pBuf, nCmdId);

		struct in_addr in;
		in.s_addr = pBuf->peer.sin_addr.s_addr;

		WriteLog("addr = %s port = %d", inet_ntoa(in), ntohs(pBuf->peer.sin_port));

		WriteLog("send msg fail sock = %d  error = %d cmdId = %d", m_sockfd, errno, nCmdId);

		return FALSE;
	}
	else if (nSend == size)
	{
//		WriteLog("send msg size = %d", nSend);

		SBOOL bAck = FALSE;
		PARSEACK(pBuf, bAck);

		if (bAck)
		{
			pBuf->time = time(NULL);

			checksend->PushSendBuf(pBuf);

			return FALSE;
		}

		return TRUE;
	}
	else
	{
		WriteLog("send msg buf 2");

		return TRUE;
	}		
}
