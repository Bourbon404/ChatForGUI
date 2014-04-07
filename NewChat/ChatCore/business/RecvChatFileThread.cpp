// RecvChatFileThread.cpp: implementation of the CRecvChatFileThread class.
//
//////////////////////////////////////////////////////////////////////

#include "RecvChatFileThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CRecvChatFileThread::CRecvChatFileThread()
{
	m_strThreadName = RECVCHATFILE;
}

CRecvChatFileThread::~CRecvChatFileThread()
{

}

SBOOL CRecvChatFileThread::DoBusiness(PMsgbuf pBuf)
{	
	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);
	
	switch(nCmdId)
	{
	case CMD_CHATFILEBEGIN:
		BeginRecFile(pBuf);
		break;

	case CMD_CHATFILEDATA:
		RecvFileData(pBuf);
		break;
	}
	
	return TRUE;
}

void CRecvChatFileThread::BeginRecFile(PMsgbuf pBuf)
{	
	UINT nSenderId = 0; UINT nRecverId = 0;
	PARSEUSER(pBuf, nSenderId, nRecverId);

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;	

	PChatBeginFile sendFile = (PChatBeginFile)buf;
	UINT nFileNo  = sendFile->fileNo;
	UINT nTotSize  = sendFile->totSize;
	UINT nToUserId  = sendFile->toUserId;
	UINT nFromUserId = sendFile->fromUserId;
	string strFileName  = sendFile->fileName;

	WriteLog("Recv file from userId=%d toid=%d", nFromUserId, nToUserId);

	CFileRecvCtrl* pFileCtrl = new CFileRecvCtrl();
	pFileCtrl->InitRecvFileCtrl(nFromUserId, nToUserId, nFileNo, nTotSize, strFileName);
	m_allFileCtrl.push_back(pFileCtrl);

	///////////////////////////////////////////////////////////////////////////
	PMsgbuf p = bufcache->GetBuffer();
	UINT seqNum = bufUser->GetUserSeqNum(nToUserId);
	
	PACKACK(p, 1, 0);
	PACKBUFADDR(p, pBuf);
	PACKSEQSUM(p, seqNum);
	PACKCMDUSER(p, CMD_CHATFILEREADY, 0, 0);
	p->len = PackHeaderSize;

	buf = (PBYTE)p->payload;
	buf += PackHeaderSize;	
	PFileFlagData ready = (PFileFlagData)buf;

	ready->fileNo = nFileNo;
	ready->toUserId = nToUserId;
	p->len += FileFlagDataSize;

	CalcBufLen(p);
	CheckSumVal(p);

	sendctrl->PushMsg(p);
}

void CRecvChatFileThread::RecvFileData(PMsgbuf pBuf)
{
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	
	PChatFileHeader filedata = (PChatFileHeader)buf;
	UINT nToUserId  = filedata->toUserId;
	UINT nFileNo  = filedata->fileNo;
	UINT nBegin   = filedata->begin;
	UINT nSize  = filedata->size;

	CFileRecvCtrl* pFileCtrl = GetFileCtrl(nToUserId, nFileNo);
	if (pFileCtrl == NULL)  return;  

	if (pFileCtrl->RecvFileData(pBuf, nBegin, nSize))
	{
		FinishFileCtrl(nToUserId, nFileNo);
		//////		

		delete pFileCtrl;
	}	
}

CFileRecvCtrl* CRecvChatFileThread::GetFileCtrl(UINT nUserId, UINT nFileNo)
{
	list<CFileRecvCtrl*>::iterator it;

	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileRecvCtrl* pCtrl = (*it);

		UINT userId = pCtrl->GetUser();
		UINT fileNo = pCtrl->GetFileNo();
		
		if (nUserId == userId && nFileNo == fileNo)
		{
			return pCtrl;
		}
	}

	return NULL;
}

void CRecvChatFileThread::FinishFileCtrl(UINT nUserId, UINT nFileNo)
{
	list<CFileRecvCtrl*>::iterator it;
	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileRecvCtrl* pCtrl = (*it);

		UINT userId = pCtrl->GetUser();
		UINT fileNo = pCtrl->GetFileNo();
		
		if (nUserId == userId && nFileNo == fileNo)
		{
			m_allFileCtrl.erase(it);
			break;
		}
	}
}
