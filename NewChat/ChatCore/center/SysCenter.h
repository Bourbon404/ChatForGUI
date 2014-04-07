// SysCenter.h: interface for the CSysCenter class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SYSCENTER_H_
#define _SYSCENTER_H_

#include "../include/SysInc.h"

#include "../modes/CheckSend.h"
#include "../modes/CheckRecv.h"
#include "../modes/BufferUser.h"
#include "../modes/BufferTask.h"

#include "BufferCache.h"
#include "SysThread.h"

class CSysCenter  
{
public:
	CSysCenter();
	virtual ~CSysCenter();

	void StopCenter();
	void StartCenter();

	string	GetLocalAddr();
	string	GetLocalMask();
	string	GetServerAddr();

	void SetLocalAddr(string strAddr);
	void SetLocalMask(string strMask);
	void SetServerAddr(string strServAddr);
    

	CSysThread* GetWorkerThread(string name);

	/////////////////////////////////////////
	CCheckRecv* GetCheckRecv();
	CCheckSend* GetCheckSend();
	CBufferCache* GetBufCache();
	CBufferUser* GetBufUser();
	CBufferTask* GetBufTask();
    
    //////////////////////////////////////////
	void DoUserLogin(string strUserName, string strPassword);

private:
	void InitUserSelf();
	void ReadAddrConfig();
    SBOOL CreateServSocket();

private:
	int m_sockfd;	
	string  m_strLocalAddr;
	string  m_strLocalMask;
	string  m_strServerAddr;

	CCheckRecv m_recv;
	CCheckSend m_send;
	CBufferCache m_cache;

	CBufferUser m_bufUser;
	CBufferTask m_bufTask;

	list<CSysThread*> m_AllThread;	
};

#endif
