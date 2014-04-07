// DispatchThread.cpp: implementation of the CDispatchThread class.
//
//////////////////////////////////////////////////////////////////////

#include "DispatchThread.h"
#include "../modes/CheckRecv.h"
#include "../modes/CheckSend.h"
#include "../center/SysCenter.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CDispatchThread::CDispatchThread()
{
	m_strThreadName = DISPATCH;
}

CDispatchThread::~CDispatchThread()
{

}

SBOOL CDispatchThread::DoBusiness(PMsgbuf pBuf)
{
	WriteLog("Dispatch Recv msg.");

	BOOL bAck = FALSE;  PARSEACK(pBuf, bAck);
	if (bAck)  DoAckRecvMsg(pBuf);

	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);
	
	SBOOL bCache = FALSE;
	switch(nCmdId)
	{
	case CMD_ACK:
		bCache = TRUE;
		DoCheckSendAck(pBuf);
		break;

	case CMD_LOGRES:
	case CMD_TXTMSG:
	case CMD_PUSHENTDATA:
	case CMD_PUSHFRIEND:
	case CMD_FRIENDFINISH:
		servcmd->PushMsg(pBuf);
		break;

	case CMD_ENTFILESEND:
	case CMD_ENTFILEREADY:
	case CMD_ENTFILEFINISH:
		sendentfile->PushMsg(pBuf);
		break;

	case CMD_CHATFILESEND:
	case CMD_CHATFILEREADY:
	case CMD_CHATFILEFINISH:
		sendchatfile->PushMsg(pBuf);
		break;

	case CMD_ENTFILEDATA:
	case CMD_ENTFILEBEGIN:
		recventfile->PushMsg(pBuf);
		break;
		
	case CMD_CHATFILEDATA:
	case CMD_CHATFILEBEGIN:
		recvchatfile->PushMsg(pBuf);
		break;		
	}
	
	return bCache;
}

void CDispatchThread::DoAckRecvMsg(PMsgbuf pBuf)
{
//	struct in_addr in;
//	in.s_addr = pBuf->peer.sin_addr.s_addr;

//	WriteLog("ack buf addr = %s port = %d", inet_ntoa(in), ntohs(pBuf->peer.sin_port));

	UINT seqNum = 0;  
	PARSESEQSUM(pBuf, seqNum);
	
	PMsgbuf msg = bufcache->GetBuffer();
	
	PACKBUFADDR(msg, pBuf);
	PACKSEQSUM(msg, seqNum);
	PACKCMDUSER(msg, CMD_ACK, 0, 0);
	msg->len = PackHeaderSize;
	
//	in.s_addr = msg->peer.sin_addr.s_addr;
//	WriteLog("buf ack addr = %s port = %d", inet_ntoa(in), ntohs(msg->peer.sin_port));

	CalcBufLen(msg);
	CheckSumVal(msg);

	sendctrl->PushMsg(msg);
}

void CDispatchThread::DoCheckSendAck(PMsgbuf pBuf)
{
	UINT nSeqNum = 0;  
	PARSESEQSUM(pBuf, nSeqNum); 	
	
	checksend->CheckSendAck(nSeqNum);
}
