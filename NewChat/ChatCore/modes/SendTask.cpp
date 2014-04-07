// RecvSeqnum.cpp: implementation of the CRecvSeqnum class.
//
//////////////////////////////////////////////////////////////////////

#include "SendTask.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSendTask::CSendTask()
{
	m_nKeyId = 0;
	m_nUserId = 0;
}

CSendTask::~CSendTask()
{

}

UINT CSendTask::GetKeyId()
{
	return m_nKeyId;
}

void CSendTask::SetKeyId(UINT nKeyId)
{
	m_nKeyId = nKeyId;
}

UINT CSendTask::GetUserId()
{
	return m_nUserId;
}

void CSendTask::SetUserId(UINT nUserId)
{
	m_nUserId = nUserId;
}
