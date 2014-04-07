// RecvSeqnum.h: interface for the CRecvSeqnum class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _RECVSEQNUM_H_
#define _RECVSEQNUM_H_

#include "../include/SysInc.h"

class CRecvSeqnum  
{
public:
	CRecvSeqnum();
	virtual ~CRecvSeqnum();

	void ResetCheck();
	
	SBOOL CheckRecvBuf(UINT nSeqNum);

private:
	vector<UINT> m_recv;
};

#endif
