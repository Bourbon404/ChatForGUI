/*
 * Event.cpp
 *
 *  Created on: 2014-01-03
 *      Author: rock
 */

#include "Event.h"

CEvent::CEvent()
{
	m_bCond = FALSE;

	pthread_cond_init(&m_cond, NULL);
	pthread_mutex_init(&m_mutex, NULL);
}

CEvent::~CEvent()
{
	pthread_cond_destroy(&m_cond);
	pthread_mutex_destroy(&m_mutex);
}

//waitTime (ms)
SBOOL CEvent::Lock(int waitTime)
{
	int retcode = 0;
	if (waitTime == 0)
	{
		pthread_mutex_lock(&m_mutex);

		while (m_bCond == FALSE)
		{
			retcode = pthread_cond_wait(&m_cond, &m_mutex);
		}

		pthread_mutex_unlock(&m_mutex);
	}
	else
	{
		struct timeval now;
		gettimeofday(&now, NULL);

		int stime = waitTime / 1000; //�ȴ�����
		waitTime -= stime*1000;

		int ntime = (now.tv_usec + waitTime*1000)*1000;  //��ǰ��������
		int sntime = ntime / (1000*1000*1000);   //����������������

		stime += sntime;     //��ǰ����
		ntime -= sntime * 1000 * 1000 * 1000;  //��ǰ����

		struct timespec timeout;
		timeout.tv_nsec = ntime;
		timeout.tv_sec = now.tv_sec + stime;

		pthread_mutex_lock(&m_mutex);

		while (m_bCond == FALSE && retcode != ETIMEDOUT)
		{
			retcode = pthread_cond_timedwait(&m_cond, &m_mutex, &timeout);
		}

		pthread_mutex_unlock(&m_mutex);
	}

	SBOOL bRet = FALSE;
	if (retcode == ETIMEDOUT)
	{
		bRet = FALSE;
	}
	else
	{
		bRet = TRUE;
	}

	return bRet;
}

SBOOL CEvent::SetEvent()
{
	pthread_mutex_lock(&m_mutex);
	
	m_bCond = TRUE;
	pthread_cond_signal(&m_cond);

	pthread_mutex_unlock(&m_mutex);

	return TRUE;
}

SBOOL CEvent::ResetEvent()
{
	pthread_mutex_lock(&m_mutex);

	m_bCond = FALSE;

	pthread_mutex_unlock(&m_mutex);

	return TRUE;
}

