// ServCmdThread.h: interface for the CServCmdThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SERVCMDTHREAD_H_
#define _SERVCMDTHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"

class CServCmdThread : public CSysThread  
{
public:
	CServCmdThread();
	virtual ~CServCmdThread();

public:	
	virtual SBOOL DoBusiness(PMsgbuf pBuf);

private:
	void Login(PMsgbuf pBuf);
	void DoLookUser(PMsgbuf pBuf);
	void DoPushFriend(PMsgbuf pBuf);
	void DoRecvTextMsg(PMsgbuf pBuf);

	void DoFriendFinish(PMsgbuf pBuf);
	void DoPushEntData(PMsgbuf pBuf);
};

#endif
