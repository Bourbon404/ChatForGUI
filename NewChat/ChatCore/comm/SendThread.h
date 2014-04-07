// SendThread.h: interface for the CSendThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SENDTHREAD_H_
#define _SENDTHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"

class CSendThread : public CSysThread  
{
public:
	CSendThread(int sockfd);
	virtual ~CSendThread();

public:	
	virtual SBOOL DoBusiness(PMsgbuf pBuf);

private:
	int m_sockfd;
};

#endif
