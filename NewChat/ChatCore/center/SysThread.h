// SysThread.h: interface for the CSysThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SYSTHREAD_H_
#define _SYSTHREAD_H_

#include "../modes/Event.h"
#include "../include/SysInc.h"
#include "../modes/CriticalSection.h"

class CSysThread  
{
public:
	CSysThread();
	virtual ~CSysThread();

	void StopThread();
	SBOOL StartThread();

	string GetThreadName();
	
	void PushMsg(PMsgbuf pBuf);
 	void PushMsg(list<PMsgbuf>& bufs);

	virtual void DoBusinessMsg();

	static void* BusinessThread(void* me);

public:
	virtual SBOOL DoBusiness(PMsgbuf pBuf) = 0;

protected:
	CEvent m_stop;
	pthread_t m_tid;

	string m_strThreadName;

	list<PMsgbuf> m_AllMsg;
	CCriticalSection m_csMsg;
};

#endif
