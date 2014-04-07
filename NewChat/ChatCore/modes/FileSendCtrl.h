// FileSendCtrl.h: interface for the CFileSendCtrl class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _FILESENDCTRL_H_
#define _FILESENDCTRL_H_

#include "../include/SysInc.h"

class CFileSendCtrl  
{
public:
	CFileSendCtrl();
	virtual ~CFileSendCtrl();

	UINT GetUser();
	UINT GetFileNo();
	CSendTask* GetSendTask();
	
	void PackFileData(list<PMsgbuf>& filebuf, PMsgbuf p, UINT nCmdId);
	
	void InitSendFileCtrl(UINT nUserId, UINT nFileNo, PBYTE data, UINT nSize, CSendTask* pSendTask);
	
private:
	UINT m_nUserId;
	UINT m_nFileNo;
	UINT m_nSize;
	PBYTE m_pBuf;
	CSendTask* m_pSendTask;
};

#endif
