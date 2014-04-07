// RecvThread.h: interface for the CRecvThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _RECVTHREAD_H_
#define _RECVTHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"

class CRecvThread : public CSysThread    
{
public:
	CRecvThread(int sockfd);
	virtual ~CRecvThread();

	virtual void DoBusinessMsg();

public:	
	virtual SBOOL DoBusiness(PMsgbuf pBuf);

private:
    fd_set m_rdfds;
    int m_sockfd;
    struct timeval m_tv;
};

#endif
