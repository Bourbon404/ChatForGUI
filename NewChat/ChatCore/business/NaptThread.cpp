// NaptThread.cpp: implementation of the CNaptThread class.
//
//////////////////////////////////////////////////////////////////////

#include "NaptThread.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CNaptThread::CNaptThread()
{
	m_strThreadName = NAPTCTRL;
}

CNaptThread::~CNaptThread()
{

}

void CNaptThread::DoBusinessMsg()
{
	int span = 3;
	CTime tmCheck = time(NULL);

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

		if (pBuf)
		{
			if (DoBusiness(pBuf))
			{
				bufcache->RelBuffer(pBuf);
 			}
		}
		else
		{
			checksend->CheckResend();

			CTime tmNow = time(NULL);
			if (tmNow - tmCheck > span)
			{
				tmCheck = tmNow;

				bufUser->SendUserOnline();
			}
		}
	}
}

SBOOL CNaptThread::DoBusiness(PMsgbuf pBuf)
{
	return FALSE;
}
