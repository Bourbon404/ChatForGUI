// SendTask.h: interface for the CRecvSeqnum class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _SENDTASK_H_
#define _SENDTASK_H_

#include "../include/SysInc.h"

class CSendTask
{
public:
	CSendTask();
	virtual ~CSendTask();

	UINT GetKeyId();
	void SetKeyId(UINT nKeyId);

	UINT GetUserId();
	void SetUserId(UINT nUserId);
	
private:
	UINT m_nKeyId;
	UINT m_nUserId;
};

#endif
