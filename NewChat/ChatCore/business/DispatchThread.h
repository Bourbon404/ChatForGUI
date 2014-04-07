// DispatchThread.h: interface for the CDispatchThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _DISPATCHTHREAD_H_
#define _DISPATCHTHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"

class CDispatchThread : public CSysThread  
{
public:
	CDispatchThread();
	virtual ~CDispatchThread();

public:	
	virtual SBOOL DoBusiness(PMsgbuf pBuf);

private:
	void DoAckRecvMsg(PMsgbuf pBuf);	
	void DoCheckSendAck(PMsgbuf pBuf);
};

#endif
