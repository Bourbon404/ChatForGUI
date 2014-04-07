// SendChatFileThread.cpp: implementation of the CSendChatFileThread class.
//
//////////////////////////////////////////////////////////////////////

#include "SendChatFileThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSendChatFileThread::CSendChatFileThread()
{
	m_nFileNo = 0;
	m_strThreadName = SENDCHATFILE;
}

CSendChatFileThread::~CSendChatFileThread()
{
	list<CFileSendCtrl*>::iterator it;
	
	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileSendCtrl* pCtrl = (*it);
		
		delete pCtrl;
	}
}

SBOOL CSendChatFileThread::DoBusiness(PMsgbuf pBuf)
{
	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);
	
	switch(nCmdId)
	{
	case CMD_CHATFILESEND:
		PreSendFile(pBuf);
		break;

	case CMD_CHATFILEREADY:
		ChatFileData(pBuf);
		break;

	case CMD_CHATFILEFINISH:
		FinishSendFile(pBuf);
		break;
	}
	
	return TRUE;
}

void CSendChatFileThread::PreSendFile(PMsgbuf pBuf)
{
	PUserCtrl self = bufUser->GetUserSelf();
	if (self == NULL)  return;

	UINT selfId = self->userInfo.nUserId;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;	
	
	PChatFileData sendFile = (PChatFileData)buf;
	UINT nToUserId = sendFile->toUserId;
	string strFileName = sendFile->fileName;
	UINT nSize = sendFile->size;
	PBYTE data = sendFile->data;

	CSendTask* pSendTask = (CSendTask*)pBuf->task;

	m_nFileNo++;
	CFileSendCtrl* pFileCtrl = new CFileSendCtrl();
	pFileCtrl->InitSendFileCtrl(nToUserId, m_nFileNo, data, nSize, pSendTask);
	m_allFileCtrl.push_back(pFileCtrl);

	///////////////////////////////////////////////////////////////////////////
	PMsgbuf p = bufcache->GetBuffer();
	UINT nPackId = bufUser->GetUserSeqNum(nToUserId);
	
	PACKACK(p, 1, 0);
	PACKBUFADDR(p, pBuf);
	PACKSEQSUM(p, nPackId);
	PACKCMDUSER(p, CMD_CHATFILEBEGIN, selfId, 0);
	p->len = PackHeaderSize;

	buf = (PBYTE)p->payload;
	buf += PackHeaderSize;	
	PChatBeginFile begin = (PChatBeginFile)buf;

	strcpy(begin->fileName,strFileName.c_str());
	begin->fromUserId = selfId;
	begin->toUserId = nToUserId;
	begin->fileNo = m_nFileNo;
 	begin->totSize = nSize;
	begin->toUserId = nToUserId;
	p->len += ChatBeginFileSize;

	CalcBufLen(p);
	CheckSumVal(p);

	sendctrl->PushMsg(p);
}

void CSendChatFileThread::ChatFileData(PMsgbuf pBuf)
{
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	PFileFlagData fileFlag = (PFileFlagData)buf;
	
	UINT nFileNo = fileFlag->fileNo;
	UINT nToUserId = fileFlag->toUserId;

	CFileSendCtrl* pFileCtrl = GetFileCtrl(nToUserId, nFileNo);
	if (pFileCtrl == NULL)  return;  
	
	list<PMsgbuf> filebuf;
	pFileCtrl->PackFileData(filebuf, pBuf, CMD_CHATFILEDATA);

	sendctrl->PushMsg(filebuf);
}

void CSendChatFileThread::FinishSendFile(PMsgbuf pBuf)
{
	//CMD_FILEFINISH
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;

	WriteLog("Finish Send file");

	PFileFlagData fileFlag = (PFileFlagData)buf;	
	UINT nFileNo = fileFlag->fileNo;
	UINT nToUserId = fileFlag->toUserId;

	WriteLog("Finish Send file user=%d fileno=%d", nToUserId, nFileNo);

	FinishFileCtrl(nToUserId, nFileNo);
}

void CSendChatFileThread::FinishFileCtrl(UINT nUserId, UINT nFileNo)
{
	list<CFileSendCtrl*>::iterator it;
	for (it = m_allFileCtrl.begin(); it != m_allFileCtrl.end(); it++)
	{
		CFileSendCtrl* pCtrl = (*it);

		UINT userId = pCtrl->GetUser();
		UINT fileNo = pCtrl->GetFileNo();
		WriteLog("Ctrl Send file user=%d fileNo=%d", userId, fileNo);
		
		if (nUserId == userId && nFileNo == fileNo)
		{
			CSendTask* pSendTask;
			pSendTask = pCtrl->GetSendTask();
			WriteLog("Finish Send file fileNo = %d", fileNo);

			if (pSendTask)
			{
				WriteLog("Success send file task");

				SuccessSend(pSendTask);

				buftask->ReleaseTask(pSendTask);
			}

			delete pCtrl;
		
			m_allFileCtrl.erase(it);

			break;
		}
	}
}

CFileSendCtrl* CSendChatFileThread::GetFileCtrl(UINT nUserId, UINT nFileNo)
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

void CSendChatFileThread::SuccessSend(CSendTask* pSendTask)
{
	WriteLog("Send file Success.");

	UINT nKeyId = pSendTask->GetKeyId();
	UINT nUserId = pSendTask->GetUserId();

	PMsgbuf pBuf = bufcache->GetBuffer();
	PBYTE buf = (PBYTE)pBuf->payload;

	struct SendAct
	{
		int act;
		int what;
		int userid;
		int keyId;
	};

	int size = sizeof(struct SendAct);

	struct SendAct *pAct = (struct SendAct *)buf;
	pAct->act = ACTION_MSG;
	pAct->what = SENDMSG_ACT;
	pAct->userid = nUserId;
	pAct->keyId = nKeyId;

//	g_sysCenter.NotifyEventData(buf, size);

	bufcache->RelBuffer(pBuf);
}
