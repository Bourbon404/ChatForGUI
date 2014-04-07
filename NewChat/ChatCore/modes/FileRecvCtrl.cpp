// FileRecvCtrl.cpp: implementation of the CFileRecvCtrl class.
//
//////////////////////////////////////////////////////////////////////

#include "FileRecvCtrl.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CFileRecvCtrl::CFileRecvCtrl()
{
	m_nFromUserId = 0;
	m_nUserId = 0;
	m_nFileNo = 0;
	m_nTotSize = 0;
	m_strFileName = "";
	
	m_pFileData = NULL;
}

CFileRecvCtrl::~CFileRecvCtrl()
{
	if (m_pFileData)  delete [] m_pFileData;
}

UINT CFileRecvCtrl::GetUser()
{
	return m_nUserId;
}

UINT CFileRecvCtrl::GetFileNo()
{
	return m_nFileNo;
}

BOOL CFileRecvCtrl::RecvFileData(PMsgbuf pBuf, UINT nBegin, UINT nSize)
{
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize + ChatFileHeaderSize;

	PBYTE filebuf = m_pFileData + nBegin;
	memcpy(filebuf, buf, nSize);

	m_nTotRecv += nSize;

	BOOL bFinish = FALSE;
	WriteLog("Recv total size = %d", m_nTotRecv);

	if (m_nTotRecv == m_nTotSize)
	{
		//WriteRecvFile();

		bFinish = TRUE;

		PMsgbuf p = bufcache->GetBuffer();
		UINT seqNum = bufUser->GetUserSeqNum(m_nUserId);

		PACKACK(p, 1, 1);
		PACKBUFADDR(p, pBuf);
		PACKSEQSUM(p, seqNum);
		PACKCMDUSER(p, CMD_CHATFILEFINISH, m_nUserId, 0);
		p->len = PackHeaderSize;

		PBYTE buf = (PBYTE)p->payload;
		buf += PackHeaderSize;

		PFileFlagData fileFlag = (PFileFlagData)buf;
		fileFlag->fileNo = m_nFileNo;
		fileFlag->toUserId = m_nUserId;
		
		p->len += FileFlagDataSize;

		CalcBufLen(p);
		CheckSumVal(p);

		sendctrl->PushMsg(p);

		RecvUserFile();
	}

	return bFinish;
}

void CFileRecvCtrl::InitRecvFileCtrl(UINT nFromUserId, UINT nUserId, UINT nFileNo, UINT nTotSize, string strFileName)
{
	m_nTotRecv = 0; 

	m_nFromUserId = nFromUserId;

	m_nUserId = nUserId;
	m_nFileNo = nFileNo;
	m_nTotSize = nTotSize;
	m_strFileName = strFileName;

	m_pFileData = new BYTE[m_nTotSize];
}

void CFileRecvCtrl::WriteRecvFile()
{
	/*
	string strFilePath = "D:\\";
	strFilePath += m_strFileName;

	CFile file;
	if (file.Open(strFilePath.c_str(), CFile::modeWrite | CFile::typeBinary | CFile::modeCreate))
	{	
		file.Write(m_pFileData, m_nTotSize);

		file.Close();
	}
	*/
}

void CFileRecvCtrl::RecvUserFile()
{
	WriteLog("Recv user chat file.");

	struct RecvFileAct
	{
		int act;
		int what;
		int userid;
		int size;
		int fileType;
		char fileName[52];
	};

	int size = sizeof(struct RecvFileAct);
	int nSize = size + m_nTotSize;

	PBYTE buf = new BYTE[nSize];
	memset(buf, 0, nSize);

	struct RecvFileAct *pAct = (struct RecvFileAct *)buf;
	pAct->act = ACTION_MSG;
	pAct->what = RECVFILE_ACT;
	pAct->userid = m_nFromUserId;
	pAct->size = m_nTotSize;
	pAct->fileType = 1;
	strcpy(pAct->fileName, m_strFileName.c_str());

	PBYTE data = buf + size;
	memcpy(data, m_pFileData, m_nTotSize);

	//g_sysCenter.NotifyEventData(buf, nSize);

	delete [] buf;
}
