// FileRecvCtrl.h: interface for the CFileRecvCtrl class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _FILERECVCTRL_H_
#define _FILERECVCTRL_H_

#include "../include/SysInc.h"

class CFileRecvCtrl  
{
public:
	CFileRecvCtrl();
	virtual ~CFileRecvCtrl();

	UINT GetUser();
	UINT GetFileNo();
	
	BOOL RecvFileData(PMsgbuf pBuf, UINT nBegin, UINT nSize);
	
	void InitRecvFileCtrl(UINT nFromId, UINT nUserId, UINT nFileNo, UINT nTotSize, string strFileName);
	
private:
	void RecvUserFile();
	void WriteRecvFile();
	
private:
	UINT m_nFromUserId;
	UINT m_nUserId;
	UINT m_nFileNo;
	UINT m_nTotSize;
	string m_strFileName;
	
	UINT m_nTotRecv;
	PBYTE m_pFileData;
};

#endif
