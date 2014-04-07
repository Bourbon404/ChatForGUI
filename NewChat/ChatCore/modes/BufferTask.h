// BufferTask.h: interface for the CBufferTask class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _BUFFERTASK_H_
#define _BUFFERTASK_H_

#include "../include/SysInc.h"

class CBufferTask
{
public:
	CBufferTask();
	virtual ~CBufferTask();

	void PushTask(CSendTask* pSendTask);
	void ReleaseTask(CSendTask* pSendTask);

private:
	CCriticalSection m_csTask;
	list<CSendTask*> m_allTask;
};

#endif
