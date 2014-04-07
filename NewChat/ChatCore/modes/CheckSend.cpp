// CheckSend.cpp: implementation of the CCheckSend class.
//
//////////////////////////////////////////////////////////////////////

#include "CheckSend.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCheckSend::CCheckSend()
{

}

CCheckSend::~CCheckSend()
{

}

void CCheckSend::PushSendBuf(PMsgbuf pBuf)
{
	UINT seqNum = 0;  
	PARSESEQSUM(pBuf, seqNum); 

	WriteLog("Sent pack seqNum=%d", seqNum);

	m_csSend.Lock();
	
	m_sendbuf.insert(pair<UINT, PMsgbuf>(seqNum, pBuf));

	m_csSend.Unlock();
}

void CCheckSend::CheckResend()
{
	list<PMsgbuf> cache;
	list<PMsgbuf> resend;

	m_csSend.Lock();

	map<UINT, PMsgbuf>::iterator it;
	for (it = m_sendbuf.begin(); it != m_sendbuf.end(); it++)
	{
		PMsgbuf pBuf = it->second;
		UINT tmtime = (UINT)pBuf->time;
		
		if (tmtime == 0)	continue;
		
		DWORD now = time(NULL);
		int diff = (int)(now - tmtime);
		if (abs(diff) > SEND_CHECK)
		{	
			int times = pBuf->times;
			if (times < MAX_TRY)
			{
				times++;
				
				pBuf->times = times;
				
				WriteLog("Resend buf again\n");
				
				resend.push_back(pBuf);

				sendctrl->PushMsg(pBuf);
			}
			else
			{
				cache.push_back(pBuf);
			}
		}	
	}

	list<PMsgbuf>::iterator its;
	for (its = cache.begin(); its != cache.end(); its++)
	{
		PMsgbuf pBuf = (*its);
		
		UINT seqNum = 0;  
		PARSESEQSUM(pBuf, seqNum); 
		
		it = m_sendbuf.find(seqNum);
		m_sendbuf.erase(it);

		bufcache->RelBuffer(pBuf);
	}
	
	for (its = resend.begin(); its != resend.end(); its++)
	{
		PMsgbuf pBuf = (*its);
		
		UINT seqNum = 0;  
		PARSESEQSUM(pBuf, seqNum); 
		
		it = m_sendbuf.find(seqNum);
		m_sendbuf.erase(it);
	}

	m_csSend.Unlock();
}

void CCheckSend::CheckSendAck(UINT nSeqNum)
{
	m_csSend.Lock();

	map<UINT, PMsgbuf>::iterator it;
	it = m_sendbuf.find(nSeqNum);
	
	if (it != m_sendbuf.end())
	{
		WriteLog("Sent pack ack seqno = %d\n", nSeqNum);

		PMsgbuf pBuf = it->second;

		CSendTask* pSendTask = NULL;
		pSendTask = (CSendTask*)pBuf->task;
		if (pSendTask)
		{
			SuccessSend(pSendTask);

			buftask->ReleaseTask(pSendTask);
		}

		m_sendbuf.erase(it);
		
		bufcache->RelBuffer(pBuf);
	}

	m_csSend.Unlock();
}

void CCheckSend::SuccessSend(CSendTask* pSendTask)
{
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

	//g_sysCenter.NotifyEventData(buf, size);

	bufcache->RelBuffer(pBuf);
}
