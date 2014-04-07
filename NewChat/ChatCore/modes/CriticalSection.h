/*
 * Event.h
 *
 *  Created on: 2014-01-03
 *      Author: rock
 */

#ifndef _CRITICALSECTION_H_
#define _CRITICALSECTION_H_

#include "../include/SysInc.h"

class CCriticalSection
{
public:
	CCriticalSection();
	virtual ~CCriticalSection();

	void Lock();
	void Unlock();

private:
	pthread_mutex_t m_mutex;
};

#endif /* EVENT_H_ */
