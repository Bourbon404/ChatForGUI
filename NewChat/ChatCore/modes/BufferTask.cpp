// BufferTask.cpp: implementation of the CBufferTask class.
//
//////////////////////////////////////////////////////////////////////

#include "BufferTask.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CBufferTask::CBufferTask()
{
}

CBufferTask::~CBufferTask()
{
	list<CSendTask*>::iterator it;
	for (it = m_allTask.begin(); it != m_allTask.end(); it++)
	{
		CSendTask* pTask = (*it);
		
		delete pTask;
	}	
}

void CBufferTask::PushTask(CSendTask* pSendTask)
{
	m_csTask.Lock();
	
	m_allTask.push_back(pSendTask);

	m_csTask.Unlock();
}

void CBufferTask::ReleaseTask(CSendTask* pSendTask)
{
	m_csTask.Lock();
	
	list<CSendTask*>::iterator it;

	for (it = m_allTask.begin(); it != m_allTask.end(); it++)
	{
		CSendTask* pTask = (*it);

		if (pTask == pSendTask)
		{
			m_allTask.erase(it);
			break;
		}
	}

	delete pSendTask;

	m_csTask.Unlock();
}
