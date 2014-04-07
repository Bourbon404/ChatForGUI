// SendChatFileThread.h: interface for the CSendChatFileThread class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SENDCHATFILETHREAD_H_
#define _SENDCHATFILETHREAD_H_

#include "../include/SysInc.h"
#include "../center/SysThread.h"
#include "../modes/FileSendCtrl.h"

class CSendChatFileThread : public CSysThread  
{
public:
	CSendChatFileThread();
	virtual ~CSendChatFileThread();

	virtual SBOOL DoBusiness(PMsgbuf pBuf);
	
private:
	void PreSendFile(PMsgbuf pBuf);
	void ChatFileData(PMsgbuf pBuf);
	void FinishSendFile(PMsgbuf pBuf);
	
private:
	void SuccessSend(CSendTask* pSendTask);
	void FinishFileCtrl(UINT nUserId, UINT nFileNo);
	CFileSendCtrl* GetFileCtrl(UINT nUserId, UINT nFileNo);
	
private:
	UINT m_nFileNo;
	list<CFileSendCtrl*> m_allFileCtrl;
};

#endif
