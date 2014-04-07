// CheckSend.h: interface for the CCheckSend class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _CHECKSEND_H_
#define _CHECKSEND_H_

#include "../include/SysInc.h"

class CCheckSend  
{
public:
	CCheckSend();
	virtual ~CCheckSend();

	void PushSendBuf(PMsgbuf pBuf);
	
	void CheckResend();
	void CheckSendAck(UINT nSeqNum);

private:
	void SuccessSend(CSendTask* pSendTask);

private:
	CCriticalSection m_csSend;
	map<UINT, PMsgbuf> m_sendbuf;
};

#endif
