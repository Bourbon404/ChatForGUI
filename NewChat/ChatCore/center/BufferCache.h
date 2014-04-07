// BufferCache.h: interface for the CBufferCache class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _BUFFERCACHE_H_
#define _BUFFERCACHE_H_

#include "../include/SysInc.h"

class CBufferCache  
{
public:
	CBufferCache();
	virtual ~CBufferCache();

	PMsgbuf GetBuffer();

	void RelBuffer(PMsgbuf pBuf);

private:
	list<PMsgbuf> m_cache;
	CCriticalSection m_csCache;
};

#endif
