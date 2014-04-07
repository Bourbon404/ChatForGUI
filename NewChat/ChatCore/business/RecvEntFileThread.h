// RecvEntFileThread.h: interface for the CRecvEntFileThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _RECVENTFILETHREAD_H_
#define _RECVENTFILETHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"
#include "../modes/FileRecvCtrl.h"

class CRecvEntFileThread : public CSysThread
{
public:
	CRecvEntFileThread();
	virtual ~CRecvEntFileThread();

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
