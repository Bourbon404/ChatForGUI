// FileSendCtrl.cpp: implementation of the CFileSendCtrl class.
//
//////////////////////////////////////////////////////////////////////

#include "FileSendCtrl.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CFileSendCtrl::CFileSendCtrl()
{
	m_nUserId = 0;
	m_nFileNo = 0;
	m_nSize = 0;

	m_pBuf = NULL;
	m_pSendTask = NULL;
}

CFileSendCtrl::~CFileSendCtrl()
{
	if (m_pBuf != NULL)  delete [] m_pBuf;
}

UINT CFileSendCtrl::GetUser()
{
	return m_nUserId;
}

UINT CFileSendCtrl::GetFileNo()
{
	return m_nFileNo;
}

CSendTask* CFileSendCtrl::GetSendTask()
{
	return m_pSendTask;
}

void CFileSendCtrl::PackFileData(list<PMsgbuf>& filebuf, PMsgbuf p, UINT nCmdId)
{
	int totSize = m_nSize;
	
	PUserCtrl self = bufUser->GetUserSelf();
	if (self == NULL)  return;
	
	UINT selfId = self->userInfo.nUserId;
	
	if (totSize > 0)
	{
		int begin = 0;

		while (begin < totSize)
		{
			PMsgbuf pBuf = bufcache->GetBuffer();
			filebuf.push_back(pBuf);
			
			UINT nPackId = bufUser->GetUserSeqNum();
			
			PACKACK(pBuf, 1, 1);
			PACKBUFADDR(pBuf, p);
			PACKSEQSUM(pBuf, nPackId);
			PACKCMDUSER(pBuf, nCmdId, selfId, 0);
			pBuf->len = PackHeaderSize;
			
			PBYTE buf = (PBYTE)pBuf->payload;
			buf += PackHeaderSize;
			
			PChatFileHeader header = (PChatFileHeader)buf;
			header->fromUserId = selfId;
			header->toUserId = m_nUserId;
			header->fileNo = m_nFileNo;
			header->begin = begin;
			
			buf += ChatFileHeaderSize;
			pBuf->len += ChatFileHeaderSize;
			
			UINT nSize = totSize - begin;    //????????
			UINT nBufLen = BUF_SIZE - pBuf->len;
			if (nSize > nBufLen)
			{
				nSize = nBufLen;
			}
			
			header->size = nSize;
			
			PBYTE data = m_pBuf + begin;
			memcpy(buf, data, nSize);
			
			begin += nSize;
			pBuf->len += nSize;
			
			CalcBufLen(pBuf);
			CheckSumVal(pBuf);
		}
	}
}

void CFileSendCtrl::InitSendFileCtrl(UINT nUserId, UINT nFileNo, PBYTE data, UINT nSize, CSendTask* pSendTask)
{
	m_nUserId = nUserId;
	m_nFileNo = nFileNo;
	m_nSize = nSize;

	m_pBuf = data;
	m_pSendTask = pSendTask;

	//CFile file;
	/*
	if (file.Open(strFilePath.c_str(), CFile::modeRead | CFile::typeBinary))
	{	
		totSize = file.GetLength();

		file.Close();
	}
	*/
}
