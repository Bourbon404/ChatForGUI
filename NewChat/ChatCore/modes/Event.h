/*
 * Event.h
 *
 *  Created on: 2014-01-03
 *      Author: rock
 */

#ifndef EVENT_H_
#define EVENT_H_

#include "../include/SysInc.h"

class CEvent
{
public:
	CEvent();
	virtual ~CEvent();

	SBOOL Lock(int waitTime = 0);

	SBOOL SetEvent();
	SBOOL ResetEvent();

private:
	SBOOL m_bCond;
	pthread_cond_t m_cond;
	pthread_mutex_t m_mutex;
};

#endif /* EVENT_H_ */
