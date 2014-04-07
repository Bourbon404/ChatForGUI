// CheckRecv.cpp: implementation of the CCheckRecv class.
//
//////////////////////////////////////////////////////////////////////

#include "CheckRecv.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCheckRecv::CCheckRecv()
{

}

CCheckRecv::~CCheckRecv()
{
	CRecvSeqnum* pRecvSeq;
	map<UINT, CRecvSeqnum*>::iterator it;
	for (it = m_recv.begin(); it != m_recv.end(); it++)
	{
		pRecvSeq = it->second;
		delete pRecvSeq;
	}
}

void CCheckRecv::ResetCheck(UINT nUserId)
{
	m_csRecv.Lock();
	
	map<UINT, CRecvSeqnum*>::iterator it;
	it = m_recv.find(nUserId);
	
	if (it != m_recv.end())
	{
		CRecvSeqnum* pRecvReq = it->second;

		pRecvReq->ResetCheck();
	}
	
	m_csRecv.Unlock();
}

SBOOL CCheckRecv::CheckRecvBuf(UINT nUserId, UINT nSeqNum)
{
	m_csRecv.Lock();
	
	map<UINT, CRecvSeqnum*>::iterator it;
	it = m_recv.find(nUserId);
	
	CRecvSeqnum* pRecvReq;
	if (it == m_recv.end())
	{
		pRecvReq = new CRecvSeqnum();
		
		m_recv.insert(pair<UINT, CRecvSeqnum*>(nUserId, pRecvReq));
	}
	else
	{
		pRecvReq = it->second;
	}
	
	SBOOL bCheck = pRecvReq->CheckRecvBuf(nSeqNum);

	m_csRecv.Unlock();

	return bCheck;
}