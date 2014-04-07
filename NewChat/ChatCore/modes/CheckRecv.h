// CheckRecv.h: interface for the CCheckRecv class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _CHECKRECV_H_
#define _CHECKRECV_H_

#include "RecvSeqnum.h"
#include "../include/SysInc.h"

class CCheckRecv  
{
public:
	CCheckRecv();
	virtual ~CCheckRecv();

	void ResetCheck(UINT nUserId);

	SBOOL CheckRecvBuf(UINT nUserId, UINT nSeqNum);

private:
	CCriticalSection m_csRecv;
	map<UINT, CRecvSeqnum*> m_recv;
};

#endif
