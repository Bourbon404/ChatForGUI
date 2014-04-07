// SendEntFileThread.h: interface for the CSendEntFileThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SENDENTFILETHREAD_H_
#define _SENDENTFILETHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"
#include "../modes/FileSendCtrl.h"

class CSendEntFileThread : public CSysThread  
{
public:
	CSendEntFileThread();
	virtual ~CSendEntFileThread();

	virtual SBOOL DoBusiness(PMsgbuf pBuf);
	
private:
	void PreSendFile(PMsgbuf pBuf);
	void EntFileData(PMsgbuf pBuf);
	void FinishSendFile(PMsgbuf pBuf);
	
	void FinishFileCtrl(UINT nUserId, UINT nFileNo);
	CFileSendCtrl* GetFileCtrl(UINT nUserId, UINT nFileNo);
	
private:
	UINT m_nFileNo;
	list<CFileSendCtrl*> m_allFileCtrl;
};

#endif
