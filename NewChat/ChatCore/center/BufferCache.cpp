// BufferCache.cpp: implementation of the CBufferCache class.
//
//////////////////////////////////////////////////////////////////////

#include "BufferCache.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CBufferCache::CBufferCache()
{

}

CBufferCache::~CBufferCache()
{
	PMsgbuf pBuf;
	list<PMsgbuf>::iterator it;

	for (it = m_cache.begin(); it != m_cache.end(); it++)
	{
		pBuf = (*it);

		PBYTE buf = (PBYTE)pBuf->payload;

		delete [] buf;
		
		delete pBuf;
	}
}

PMsgbuf CBufferCache::GetBuffer()
{	
	PMsgbuf pBuf = NULL;

	m_csCache.Lock();

	SBOOL bEmpty = m_cache.empty();
	if (!bEmpty)
	{
		pBuf = m_cache.front();

		m_cache.pop_front();
	}

	m_csCache.Unlock();
	
	if (pBuf == NULL)
	{
		pBuf = new Msgbuf;		

		pBuf->payload = new BYTE[BUF_SIZE];
	}

	pBuf->len = 0;
	pBuf->ptr = 0;
	pBuf->time = 0;
	pBuf->times = 0;
	pBuf->task = NULL;

	PBYTE buf = (PBYTE)pBuf->payload;
	memset(buf, 0, BUF_SIZE);

	return pBuf;
}

void CBufferCache::RelBuffer(PMsgbuf pBuf)
{
	m_csCache.Lock();
	
	m_cache.push_back(pBuf);

	m_csCache.Unlock();
}
