// SysCenter.cpp: implementation of the CSysCenter class.
//
//////////////////////////////////////////////////////////////////////

#include "SysCenter.h"
#include "../comm/RecvThread.h"
#include "../comm/SendThread.h"
#include "../business/DispatchThread.h"
#include "../business/NaptThread.h"
#include "../business/RecvEntFileThread.h"
#include "../business/SendEntFileThread.h"
#include "../business/RecvChatFileThread.h"
#include "../business/SendChatFileThread.h"
#include "../business/ServCmdThread.h"


CSysCenter g_sysCenter;
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSysCenter::CSysCenter()
{
	m_sockfd = -1;
	m_strLocalAddr = "192.168.1.119";
	m_strLocalMask = "255.255.254.0";
	m_strServerAddr = "192.168.1.103";
}

CSysCenter::~CSysCenter()
{
	if (m_sockfd != -1)
	{
        shutdown(m_sockfd, SHUT_RDWR);
        
		close(m_sockfd);
		m_sockfd = -1;
	}
}

string CSysCenter::GetLocalAddr()
{
	return m_strLocalAddr;
}

string CSysCenter::GetLocalMask()
{
	return m_strLocalMask;
}

string CSysCenter::GetServerAddr()
{
	return m_strServerAddr;
}

void CSysCenter::SetLocalAddr(string strLocalAddr)
{
    m_strLocalAddr = strLocalAddr;
}

void CSysCenter::SetLocalMask(string strLocalMask)
{
    m_strLocalMask = strLocalMask;
}

void CSysCenter::SetServerAddr(string strServAddr)
{
    m_strServerAddr = strServAddr;
	m_strServerAddr = "192.168.1.103";
}

void CSysCenter::StopCenter()
{
	DWORD dwCount = m_AllThread.size();
	if (dwCount > 0)
	{		
		list<CSysThread*>::iterator it;
		for (it = m_AllThread.begin(); it != m_AllThread.end(); it++)
		{
			CSysThread* pSysThread = (*it);

			pSysThread->StopThread();			
			
		}		
	}

	WriteLog("All business thread exit.");
}

void CSysCenter::StartCenter()
{
	ReadAddrConfig();

	InitUserSelf();
	
	if (CreateServSocket() == FALSE)  return;
    
    WriteLog("Client startup main ip address=%s port=%d", m_strServerAddr.c_str(), CLIENT_UDP_PORT);

	CSysThread* pThread;
	pThread = new CRecvThread(m_sockfd);
	pThread->StartThread();	
	m_AllThread.push_back(pThread);

	pThread = new CSendThread(m_sockfd);
	pThread->StartThread();	
	m_AllThread.push_back(pThread);

	pThread = new CDispatchThread();
	pThread->StartThread();	
	m_AllThread.push_back(pThread);

	pThread = new CServCmdThread();
	pThread->StartThread();	
	m_AllThread.push_back(pThread);
	
	pThread = new CRecvChatFileThread();
	pThread->StartThread();
    m_AllThread.push_back(pThread);

	pThread = new CRecvEntFileThread();
	pThread->StartThread();
    m_AllThread.push_back(pThread);

	//???t???????
	pThread = new CSendEntFileThread();
	pThread->StartThread();
    m_AllThread.push_back(pThread);

	pThread = new CSendChatFileThread();
	pThread->StartThread();	
	m_AllThread.push_back(pThread);

	pThread = new CNaptThread();
	pThread->StartThread();
	m_AllThread.push_back(pThread);
}

CSysThread* CSysCenter::GetWorkerThread(string name)
{
	list<CSysThread*>::iterator it;
	for (it = m_AllThread.begin(); it != m_AllThread.end(); it++)
	{
		CSysThread* pSysThread = (*it);
		
		string strName = pSysThread->GetThreadName();

		if (strName == name)  return pSysThread;		
	}

	return NULL;
}

CCheckRecv* CSysCenter::GetCheckRecv()
{
	return &m_recv;
}

CCheckSend* CSysCenter::GetCheckSend()
{
	return &m_send;
}

CBufferCache* CSysCenter::GetBufCache()
{
	return &m_cache;
}

CBufferUser* CSysCenter::GetBufUser()
{
	return &m_bufUser;
}

CBufferTask* CSysCenter::GetBufTask()
{
	return &m_bufTask;
}

void CSysCenter::InitUserSelf()
{
	m_strServerAddr = "192.168.1.103";
	PUserCtrl user = bufUser->GetUserSelf();
	if (user == NULL)
	{		
		user = new UserCtrl;

		InitUserCtrl(user);
		
		bufUser->SetUserSelf(user);
	}
	
	UINT ipAddr = inet_addr(m_strLocalAddr.c_str());  ipAddr = ntohl(ipAddr);
	UINT ipMask = inet_addr(m_strLocalMask.c_str());  ipMask = ntohl(ipMask);

	UINT addr = inet_addr(m_strServerAddr.c_str());	 addr = ntohl(addr);
	UINT nServPort = SERVER_UDP_PORT;  UINT nLocalPort = CLIENT_UDP_PORT;
	
	user->netStatus.nInetAddr = addr;
	user->netStatus.nInetPort = nServPort;

	user->netStatus.nLocalAddr = ipAddr;
	user->netStatus.nLocalMask = ipMask;
	user->netStatus.nLocalPort = nLocalPort;
}

void CSysCenter::ReadAddrConfig()
{

}


void CSysCenter::DoUserLogin(string strUserName, string strPassword)
{
	PUserCtrl user = bufUser->GetUserSelf();
	if (user == NULL)
	{
		user = new UserCtrl;

		InitUserCtrl(user);

		//bufUser->PushBufUser(user);
		bufUser->SetUserSelf(user);
	}

	user->userInfo.strUserName = strUserName;

	string strAddr = g_sysCenter.GetLocalAddr();
	string strMask = g_sysCenter.GetLocalMask();

	UINT ipAddr = inet_addr(strAddr.c_str());	 ipAddr = ntohl(ipAddr);
	UINT ipMask = inet_addr(strMask.c_str());	 ipMask = ntohl(ipMask);

	UINT nCmdId = CMD_LOGIN;
	PMsgbuf pBuf = bufcache->GetBuffer();

	int ack = 1;
	PACKACK(pBuf, ack, 0);
	PACKCMD(pBuf, nCmdId);
	pBuf->len = PackHeaderSize;

	string strServAddr = g_sysCenter.GetServerAddr();

	UINT addr = inet_addr(strServAddr.c_str());
	addr = ntohl(addr);  UINT nPort = SERVER_UDP_PORT;

	UINT seqNum = bufUser->GetUserSeqNum();

	PACKSEQSUM(pBuf, seqNum);
	PACKADDR(pBuf, addr, nPort);

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += pBuf->len;

	PUserLogin login = (PUserLogin)buf;

	login->nUserId = 0;
	strcpy(login->userName, strUserName.c_str());
	strcpy(login->password, strPassword.c_str());
	login->localAddr = ipAddr;
	login->localMask = ipMask;
	login->localPort = CLIENT_UDP_PORT;

	pBuf->len += UserLoginSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}

SBOOL CSysCenter::CreateServSocket()
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1)
    {
		return FALSE;
    }
	
    struct sockaddr_in localaddr;
    bzero(&localaddr, sizeof(localaddr));
    localaddr.sin_family = AF_INET;
    localaddr.sin_port = htons(CLIENT_UDP_PORT);
    
    localaddr.sin_addr.s_addr = inet_addr(m_strLocalAddr.c_str());
    bzero(&(localaddr.sin_zero), 8);
    
    if (bind(sockfd, (struct sockaddr*)&localaddr, sizeof(localaddr)))
    {
        close(sockfd);
        return FALSE;
    }
    
    WriteLog("Client startup main ip address=%s port=%d", m_strLocalAddr.c_str(), CLIENT_UDP_PORT);
	
    m_sockfd = sockfd;
    
	return TRUE;
}
