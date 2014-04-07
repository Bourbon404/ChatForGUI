// BufferUser.h: interface for the CBufferUser class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _BUFFERUSER_H_
#define _BUFFERUSER_H_

#include "../include/SysInc.h"

class CBufferUser  
{
public:
	CBufferUser();
	virtual ~CBufferUser();

	void SendUserOnline();
	void SentUserPack(UINT nUserId);

	PUserCtrl GetUserSelf();
	void SetUserSelf(PUserCtrl user);

	void PushBufUser(PUserCtrl user);

	UINT GetUserSeqNum(UINT nUserId = 0);

	PUserCtrl FindUser(UINT nUserId);
	PUserCtrl FindUser(string username);

private:
	void SendOnlineMsg(PUserCtrl pUser);

private:
	PUserCtrl m_userSelf;
	CCriticalSection m_csUser;
	map<UINT, PUserCtrl> m_allUser;
};

#endif
