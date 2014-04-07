// NaptThread.h: interface for the CNaptThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _NAPTTHREAD_H_
#define _NAPTTHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"

class CNaptThread : public CSysThread  
{
public:
	CNaptThread();
	virtual ~CNaptThread();

public:	
	virtual void DoBusinessMsg();

	virtual SBOOL DoBusiness(PMsgbuf pBuf);
};

#endif
