// BufferUser.cpp: implementation of the CBufferUser class.
//
//////////////////////////////////////////////////////////////////////

#include "BufferUser.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CBufferUser::CBufferUser()
{
	m_userSelf = NULL;
}

CBufferUser::~CBufferUser()
{
	map<UINT, PUserCtrl>::iterator it;
	for (it = m_allUser.begin(); it != m_allUser.end(); it++)
	{
		PUserCtrl user = it->second;
		if (user == m_userSelf)  continue;
		
		delete user;
	}	

	if (m_userSelf)  delete m_userSelf;
}

void CBufferUser::SendUserOnline()
{
	m_csUser.Lock();

	map<UINT, PUserCtrl>::iterator it;
	for (it = m_allUser.begin(); it != m_allUser.end(); it++)
	{
		PUserCtrl pUser = it->second;
		
		if (pUser->netStatus.bNatOk)
		{
			CTime tmNow = time(NULL);
			CTime tmLastSend = pUser->netStatus.lastSend;
			
			if (tmNow - tmLastSend > SEND_CHECK)
			{
				SendOnlineMsg(pUser);
			}			
		}
	}
	
	m_csUser.Unlock();
}

void CBufferUser::SentUserPack(UINT nUserId)
{
	m_csUser.Lock();

	if (nUserId == 0)
	{
		m_userSelf->netStatus.lastSend = time(NULL);
	}
	else
	{
		map<UINT, PUserCtrl>::iterator it;
		it = m_allUser.find(nUserId);
		
		if (it != m_allUser.end())
		{
			PUserCtrl user = it->second;

			user->netStatus.lastSend = time(NULL);
		}
	}
	
	m_csUser.Unlock();
}

void CBufferUser::PushBufUser(PUserCtrl user)
{
	UINT nUserId = user->userInfo.nUserId;

	m_csUser.Lock();

	m_allUser.insert(pair<UINT, PUserCtrl>(nUserId, user));

	m_csUser.Unlock();
}

PUserCtrl CBufferUser::GetUserSelf()
{
	return m_userSelf;
}

void CBufferUser::SetUserSelf(PUserCtrl user)
{
	m_userSelf = user;
}

UINT CBufferUser::GetUserSeqNum(UINT nUserId)
{
	UINT nSeqNum = 0;

	m_csUser.Lock();

	PUserCtrl user = NULL;

	if (nUserId == 0)
	{
		user = m_userSelf;
	}
	else
	{
		map<UINT, PUserCtrl>::iterator it;
		it = m_allUser.find(nUserId);
		
		if (it != m_allUser.end())
		{
			user = it->second;
		}
	}
	
	if (user)
	{
		nSeqNum = user->netStatus.nSeqNum;
		
		nSeqNum++;

		user->netStatus.nSeqNum = nSeqNum;
	}
	
	m_csUser.Unlock();

	return nSeqNum;
}

PUserCtrl CBufferUser::FindUser(UINT nUserId)
{
	PUserCtrl user = NULL;

	m_csUser.Lock();

	map<UINT, PUserCtrl>::iterator it;
	it = m_allUser.find(nUserId);
	
	if (it != m_allUser.end())
	{
		user = it->second;
	}

	m_csUser.Unlock();
	
	return user;
}

PUserCtrl CBufferUser::FindUser(string username)
{
	PUserCtrl user = NULL;

	m_csUser.Lock();

	map<UINT, PUserCtrl>::iterator it;
	for (it = m_allUser.begin(); it != m_allUser.end(); it++)
	{
		PUserCtrl pUser = it->second;
		string strUserName = user->userInfo.strUserName;
		
		if (strUserName == username)
		{
			user = pUser;

			break;
		}
	}
	
	m_csUser.Unlock();

	return user;
}

void CBufferUser::SendOnlineMsg(PUserCtrl pUser)
{
	UINT nUserId = pUser->userInfo.nUserId;

	UINT nCmdId = CMD_HEARBET;
	PMsgbuf pBuf = bufcache->GetBuffer();
	
	UINT addr = pUser->netStatus.nInetAddr;
	UINT port = pUser->netStatus.nInetPort;	
	
	PACKACK(pBuf, 0, 0);
	PACKSEQSUM(pBuf, 0);
	PACKADDR(pBuf, addr, port);
	PACKCMDUSER(pBuf, nCmdId, nUserId, 0);
	pBuf->len = PackHeaderSize;

	CalcBufLen(pBuf);
 	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}
