// RecvThread.cpp: implementation of the CRecvThread class.
//
//////////////////////////////////////////////////////////////////////

#include "RecvThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CRecvThread::CRecvThread(int sockfd)
{
	FD_ZERO(&m_rdfds);

	m_tv.tv_sec = 0;
    	m_tv.tv_usec = 800;

	m_sockfd = sockfd;

	m_strThreadName = RECVCTRL;
}

CRecvThread::~CRecvThread()
{

}

void CRecvThread::DoBusinessMsg()
{
	while(TRUE)
	{
		if (m_stop.Lock(10)) break;

		FD_ZERO(&m_rdfds);
		
		FD_SET(m_sockfd, &m_rdfds);
		
		select(m_sockfd+1, &m_rdfds, NULL, NULL, &m_tv);
		
		if (FD_ISSET(m_sockfd, &m_rdfds))
		{
			PMsgbuf pBuf = bufcache->GetBuffer();
			
			if (DoBusiness(pBuf))
			{
				bufcache->RelBuffer(pBuf);
			}			
		}		
	}
}

SBOOL CRecvThread::DoBusiness(PMsgbuf pBuf)
{
	int nSize = BUF_SIZE;
	char* buf = (char*)pBuf->payload;	
	
	socklen_t addrlen = sizeof(struct sockaddr_in);
	int nRead = recvfrom(m_sockfd, buf, nSize, 0, (struct sockaddr*)&pBuf->peer, &addrlen);
    
    //struct in_addr in;
    //in.s_addr = pBuf->peer.sin_addr.s_addr;
    
    //WriteLog("Recv from addr = %s port = %d", inet_ntoa(in), ntohs(pBuf->peer.sin_port));
    
	if (nRead < PackHeaderSize)
	{
		return TRUE;
	}

	pBuf->len = nRead;

	if (!DoCheckSum(pBuf))
	{
		return TRUE;
	}

	dispatch->PushMsg(pBuf);

	return FALSE;
}
