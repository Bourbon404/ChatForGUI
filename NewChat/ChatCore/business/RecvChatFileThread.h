// RecvChatFileThread.h: interface for the CRecvChatFileThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _RECVCHATFILETHREAD_H_
#define _RECVCHATFILETHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"
#include "../modes/FileRecvCtrl.h"

class CRecvChatFileThread : public CSysThread  
{
public:
	CRecvChatFileThread();
	virtual ~CRecvChatFileThread();

	virtual SBOOL DoBusiness(PMsgbuf pBuf);
	
private:
	void BeginRecFile(PMsgbuf pBuf);	
	void RecvFileData(PMsgbuf pBuf);
	
	void FinishFileCtrl(UINT nUserId, UINT nFileNo);
	CFileRecvCtrl* GetFileCtrl(UINT nUserId, UINT nFileNo);	
	
private:
	list<CFileRecvCtrl*> m_allFileCtrl;
};

#endif
