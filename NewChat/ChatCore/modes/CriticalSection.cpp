/*
 * CriticalSection.cpp
 *
 *  Created on: 2010-10-21
 *      Author: rock
 */

#include "CriticalSection.h"

CCriticalSection::CCriticalSection()
{
	pthread_mutex_init(&m_mutex, NULL);
}

CCriticalSection::~CCriticalSection()
{
	pthread_mutex_destroy(&m_mutex);
}

void CCriticalSection::Lock()
{
	pthread_mutex_lock(&m_mutex);
}

void CCriticalSection::Unlock()
{
	pthread_mutex_unlock(&m_mutex);
}
