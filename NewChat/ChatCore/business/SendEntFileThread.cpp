// SendEntFileThread.cpp: implementation of the CSendEntFileThread class.
//
//////////////////////////////////////////////////////////////////////

#include "SendEntFileThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSendEntFileThread::CSendEntFileThread()
{
	m_nFileNo = 0;
	m_strThreadName = SENDENTFILE;
}

CSendEntFileThread::~CSendEntFileThread()
{
	list<CFileSendCtrl*>::iterator it;
	
	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileSendCtrl* pCtrl = (*it);
		
		delete pCtrl;
	}
}

SBOOL CSendEntFileThread::DoBusiness(PMsgbuf pBuf)
{
	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);
	
	switch(nCmdId)
	{
	case CMD_ENTFILESEND:
		PreSendFile(pBuf);
		break;

	case CMD_ENTFILEREADY:
		EntFileData(pBuf);
		break;

	case CMD_ENTFILEFINISH:
		FinishSendFile(pBuf);
		break;
	}
	
	return TRUE;
}

void CSendEntFileThread::PreSendFile(PMsgbuf pBuf)
{
	/*
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;	
	
	PEntFileData sendFile = (PEntFileData)buf;
	UINT nFromUserId = 0;
	UINT nBufNo = 0;
	UINT nToUserId = sendFile->toUserId;
	string strFileName = sendFile->fileName;
	string strFilePath = sendFile->filePath;

	m_nFileNo++;
	CFileSendCtrl* pFileCtrl = new CFileSendCtrl();
	pFileCtrl->InitSendFileCtrl(nFromUserId, nToUserId, m_nFileNo, strFilePath);
	m_allFileCtrl.push_back(pFileCtrl);

	///////////////////////////////////////////////////////////////////////////
	PMsgbuf p = bufcache->GetBuffer();
	UINT nPackId = bufUser->GetUserSeqNum(nToUserId);
	
	PACKACK(p, 1, 0);
	PACKBUFADDR(p, pBuf);
	PACKSEQSUM(p, nPackId);
	PACKCMDUSER(p, CMD_ENTFILEBEGIN, 0, 0);
	p->len = PackHeaderSize;

	buf = (PBYTE)p->payload;
	buf += PackHeaderSize;	
	PEntBeginFile begin = (PEntBeginFile)buf;

	strcpy(begin->fileName,strFileName.c_str());
	begin->fileNo = m_nFileNo;
 	begin->totSize = totSize;
	begin->toUserId = nToUserId;
	p->len += EntBeginFileSize;

	CalcBufLen(p);
	CheckSumVal(p);

	sendctrl->PushMsg(p);
	*/
}

void CSendEntFileThread::EntFileData(PMsgbuf pBuf)
{
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	PFileFlagData fileFlag = (PFileFlagData)buf;
	
	UINT nFileNo = fileFlag->fileNo;
	UINT nToUserId = fileFlag->toUserId;

	CFileSendCtrl* pFileCtrl = GetFileCtrl(nToUserId, nFileNo);
	if (pFileCtrl == NULL)  return;  
	
	list<PMsgbuf> filebuf;
	pFileCtrl->PackFileData(filebuf, pBuf, CMD_ENTFILEDATA);

	sendctrl->PushMsg(filebuf);
}

void CSendEntFileThread::FinishSendFile(PMsgbuf pBuf)
{
	//CMD_FILEFINISH
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;	

	PFileFlagData fileFlag = (PFileFlagData)buf;	
	UINT nFileNo = fileFlag->fileNo;
	UINT nToUserId = fileFlag->toUserId;

	FinishFileCtrl(nToUserId, nFileNo);
}

void CSendEntFileThread::FinishFileCtrl(UINT nUserId, UINT nFileNo)
{
	list<CFileSendCtrl*>::iterator it;
	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileSendCtrl* pCtrl = (*it);

		UINT userId = pCtrl->GetUser();
		UINT fileNo = pCtrl->GetFileNo();
		
		if (nUserId == userId && nFileNo == fileNo)
		{
			//pCtrl->FinishSendFile();

			delete pCtrl;
		
			m_allFileCtrl.erase(it);

			break;
		}
	}
}

CFileSendCtrl* CSendEntFileThread::GetFileCtrl(UINT nUserId, UINT nFileNo)
{
	list<CFileSendCtrl*>::iterator it;

	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileSendCtrl* pCtrl = (*it);

		UINT userId = pCtrl->GetUser();
		UINT fileNo = pCtrl->GetFileNo();
		
		if (nUserId == userId && nFileNo == fileNo)
		{
			return pCtrl;
		}
	}

	return NULL;
}
