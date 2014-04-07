// RecvEntFileThread.cpp: implementation of the CRecvEntFileThread class.
//
//////////////////////////////////////////////////////////////////////

#include "RecvEntFileThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CRecvEntFileThread::CRecvEntFileThread()
{
	m_strThreadName = RECVENTFILE;
}

CRecvEntFileThread::~CRecvEntFileThread()
{

}

SBOOL CRecvEntFileThread::DoBusiness(PMsgbuf pBuf)
{	
	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);
	
	switch(nCmdId)
	{
	case CMD_ENTFILEBEGIN:
		BeginRecFile(pBuf);
		break;

	case CMD_ENTFILEDATA:
		RecvFileData(pBuf);
		break;
	}
	
	return TRUE;
}

void CRecvEntFileThread::BeginRecFile(PMsgbuf pBuf)
{	
	UINT nSenderId = 0;  UINT nRecverId = 0;
	PARSEUSER(pBuf, nSenderId, nRecverId);

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;	

	PEntBeginFile sendFile = (PEntBeginFile)buf;
	UINT nToUserId  = sendFile->toUserId;
	UINT nFileNo  = sendFile->fileNo;
	UINT nTotSize  = sendFile->totSize;
	string strFileName  = sendFile->fileName;	

	CFileRecvCtrl* pFileCtrl = new CFileRecvCtrl();
	pFileCtrl->InitRecvFileCtrl(nSenderId, nToUserId, nFileNo, nTotSize, strFileName);
	m_allFileCtrl.push_back(pFileCtrl);

	///////////////////////////////////////////////////////////////////////////
	PMsgbuf p = bufcache->GetBuffer();
	UINT seqNum = bufUser->GetUserSeqNum(nToUserId);
	
	PACKACK(p, 1, 0);
	PACKBUFADDR(p, pBuf);
	PACKSEQSUM(p, seqNum);
	PACKCMDUSER(p, CMD_ENTFILEREADY, 0, 0);
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

void CRecvEntFileThread::RecvFileData(PMsgbuf pBuf)
{
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	
	PEntFileHeader filedata = (PEntFileHeader)buf;
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

CFileRecvCtrl* CRecvEntFileThread::GetFileCtrl(UINT nUserId, UINT nFileNo)
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

void CRecvEntFileThread::FinishFileCtrl(UINT nUserId, UINT nFileNo)
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
