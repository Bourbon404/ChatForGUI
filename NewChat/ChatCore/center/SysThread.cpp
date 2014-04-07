// SysThread.cpp: implementation of the CSysThread class.
//
//////////////////////////////////////////////////////////////////////

#include "SysThread.h"
#include "SysCenter.h"

void* CSysThread::BusinessThread(void* me)
{
	CSysThread* pSysThread = (CSysThread*)me;

	pSysThread->DoBusinessMsg();
	
	pthread_exit(0);

	WriteLog("SysThread exit.");

	return 0;
}

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSysThread::CSysThread()
{
	m_strThreadName = "";
}

CSysThread::~CSysThread()
{
}

void CSysThread::StopThread()
{
	m_stop.SetEvent();
			
	pthread_join(m_tid, NULL);	

	///////////////////////////////////////////////////////
	list<PMsgbuf>::iterator it;
	for (it = m_AllMsg.begin(); it != m_AllMsg.end(); it++)
	{
		PMsgbuf pBuf = (*it);
		bufcache->RelBuffer(pBuf);
	}
}

SBOOL CSysThread::StartThread()
{
	if (pthread_create(&m_tid, NULL, BusinessThread, (void*)this))
	{
		return FALSE;
	}
	
	return TRUE;
}

string CSysThread::GetThreadName()
{
	return m_strThreadName;
}

void CSysThread::PushMsg(PMsgbuf pBuf)
{
	m_csMsg.Lock();

	m_AllMsg.push_back(pBuf);

	m_csMsg.Unlock();
}

void CSysThread::PushMsg(list<PMsgbuf>& bufs)
{
	m_csMsg.Lock();

	list<PMsgbuf>::iterator it;
	
	for (it = bufs.begin(); it != bufs.end(); it++)
	{
		PMsgbuf pBuf = (*it);


		m_AllMsg.push_back(pBuf);

	}

	m_csMsg.Unlock();
}

void CSysThread::DoBusinessMsg()
{
	while(TRUE)
	{
		if (m_stop.Lock(20)) break;

		PMsgbuf pBuf = NULL;
		
		m_csMsg.Lock();	
		if (!m_AllMsg.empty())
		{
			pBuf = m_AllMsg.front();

			m_AllMsg.pop_front();
		}

		m_csMsg.Unlock();

		if (pBuf == NULL)  continue;

		if (DoBusiness(pBuf))
		{
			bufcache->RelBuffer(pBuf);
		}
	}
}
