// RecvSeqnum.cpp: implementation of the CRecvSeqnum class.
//
//////////////////////////////////////////////////////////////////////

#include "RecvSeqnum.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CRecvSeqnum::CRecvSeqnum()
{

}

CRecvSeqnum::~CRecvSeqnum()
{

}

void CRecvSeqnum::ResetCheck()
{
	m_recv.clear();	
}

SBOOL CRecvSeqnum::CheckRecvBuf(UINT nSeqNum)
{
	WriteLog("Recv pack seqno = %d\n", nSeqNum);
	
	if (nSeqNum == 0)  return FALSE;
	
	vector<UINT>::iterator it;
	for (it = m_recv.begin(); it != m_recv.end(); it++)
	{
		UINT seqNum = (*it);
		
		if (nSeqNum == seqNum)
		{
			WriteLog("Recv pack again seqno = %d\n", seqNum);
			return TRUE;
		}
	}
	
	m_recv.push_back(nSeqNum);

	return FALSE;
}