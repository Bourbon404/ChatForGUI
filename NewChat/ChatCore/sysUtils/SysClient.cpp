#include "SysClient.h"
#include "../center/SysCenter.h"

void AddUserFriend(BOOL bSelf, UINT nUserId, string strUserName)
{
	PUserCtrl user = NULL;
	if (bSelf)
	{
		user = bufUser->GetUserSelf();
	}
	else
	{
		user = new UserCtrl();
		InitUserCtrl(user);
	}

	user->userInfo.nUserId = nUserId;
	user->userInfo.strUserName = strUserName;

	bufUser->PushBufUser(user);
}

void DoUserLogin(BOOL bGetFriend, string userName, string password)
{
	WriteLog("login bGet = %d user = %s", bGetFriend, userName.c_str());

	PUserCtrl user = bufUser->GetUserSelf();	
	user->userInfo.strUserName = userName;
	
	UINT nCmdId = CMD_LOGIN;
	PMsgbuf pBuf = bufcache->GetBuffer();
	
	UINT seqNum = bufUser->GetUserSeqNum();
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;	
	
	int ack = 1;
	PACKACK(pBuf, ack, 0);
	PACKCMD(pBuf, nCmdId);
	PACKSEQSUM(pBuf, seqNum);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += pBuf->len;
	PUserLogin login = (PUserLogin)buf;

	UINT ipAddr = user->netStatus.nLocalAddr;
	UINT ipMask = user->netStatus.nLocalMask;
	UINT localPort = user->netStatus.nLocalPort;
	
	login->nUserId = 0;
	strcpy(login->userName, userName.c_str());
	strcpy(login->password, password.c_str());
	login->localAddr = ipAddr;
	login->localMask = ipMask;
	login->localPort = localPort;
	login->bGetFriend = bGetFriend;

	pBuf->len += UserLoginSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}

void UserLBS(int nSize, PBaseStaion pLbsInfo)
{
	PMsgbuf pBuf = bufcache->GetBuffer();
	PUserCtrl user = bufUser->GetUserSelf();

	UINT seqNum = bufUser->GetUserSeqNum();
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;

	PACKACK(pBuf, 1, 0);
	PACKSEQSUM(pBuf, seqNum);
	PACKCMD(pBuf, CMD_BASEPOS);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	
	UINT nUserId = user->userInfo.nUserId;
	PUserStaion posinfo = (PUserStaion)buf;
	
	posinfo->size = nSize;
	posinfo->nUserId = nUserId;

	for (int n=0; n<nSize; n++)
	{
		strcpy(posinfo->lbs[n].RSSI, pLbsInfo[n].RSSI.c_str());
		strcpy(posinfo->lbs[n].Lac, pLbsInfo[n].Lac.c_str());
		strcpy(posinfo->lbs[n].Cid, pLbsInfo[n].Cid.c_str());
	}
	
//	strcpy(posinfo->lbs[0].RSSI, pLbsInfo->lbs[0].RSSI.c_str());
//	strcpy(posinfo->lbs[1].RSSI, pLbsInfo->lbs[1].RSSI.c_str());
//	strcpy(posinfo->lbs[2].RSSI, pLbsInfo->lbs[2].RSSI.c_str());
//
//	strcpy(posinfo->lbs[0].Cid, pLbsInfo->lbs[0].Cid.c_str());
//	strcpy(posinfo->lbs[1].Cid, pLbsInfo->lbs[1].Cid.c_str());
//	strcpy(posinfo->lbs[2].Cid, pLbsInfo->lbs[2].Cid.c_str());
//
//	strcpy(posinfo->lbs[0].Lac, pLbsInfo->lbs[0].Lac.c_str());
//	strcpy(posinfo->lbs[1].Lac, pLbsInfo->lbs[1].Lac.c_str());
// 	strcpy(posinfo->lbs[2].Lac, pLbsInfo->lbs[2].Lac.c_str());

 	pBuf->len += UserStaionSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}


//¦Ë?????
void UserPos(XPoint pt)
{
	PMsgbuf pBuf = bufcache->GetBuffer();
	PUserCtrl user = bufUser->GetUserSelf();	

	UINT seqNum = bufUser->GetUserSeqNum();
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;	

	int ack = 1;
	PACKACK(pBuf, ack, 0);
	PACKSEQSUM(pBuf, seqNum);
	PACKCMD(pBuf, CMD_LALGPOS);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;
	
	UINT nUserId = user->userInfo.nUserId;

	PUserPostion postion = (PUserPostion)buf;

	postion->nUserId = nUserId;

//	postion->pt.Lat = 10.034256;
// 	postion->pt.Lng = 24.908984;
	postion->pt.Lat = pt.Lat;
	postion->pt.Lng = pt.Lng;

	pBuf->len += UserPosSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}

void GetFriend()
{
	PUserCtrl user = bufUser->GetUserSelf();

	UINT nUserId = user->userInfo.nUserId;
	UINT seqNum = bufUser->GetUserSeqNum();
	PMsgbuf pBuf = bufcache->GetBuffer();

	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;
	
	int ack = 0;
	PACKACK(pBuf, ack, 0);
	PACKSEQSUM(pBuf, seqNum);
	PACKUSER(pBuf, nUserId, 0);
	PACKCMD(pBuf, CMD_GETFRIEND);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);
}

void LookArond()
{
	PUserCtrl user = bufUser->GetUserSelf();

	UINT nUserId = user->userInfo.nUserId;
	UINT seqNum = bufUser->GetUserSeqNum();
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;

	PMsgbuf pBuf = bufcache->GetBuffer();
	

	PACKACK(pBuf, 1, 1);
	PACKSEQSUM(pBuf, seqNum);
	PACKUSER(pBuf, nUserId, 0);
	PACKCMD(pBuf, CMD_LOOKUSER);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	sendctrl->PushMsg(pBuf);	
}

void SendUserMsg(UINT nKeyId, UINT nUserId, string strMsg)
{
	PUserCtrl user = bufUser->FindUser(nUserId);
	if (user == NULL)  return;

	PUserCtrl self = bufUser->GetUserSelf();
	if (self == NULL)  return;

	UINT addr = 0;  UINT port = 0;
	UINT seqNum = 0;  UINT selfId = 0;
	selfId = self->userInfo.nUserId;
	
	if (user->netStatus.bNatOk)
	{
		addr = user->netStatus.nInetAddr;
		port = user->netStatus.nInetPort;

		seqNum = bufUser->GetUserSeqNum(nUserId);
	}
	else
	{
		addr = self->netStatus.nInetAddr;
		port = self->netStatus.nInetPort;

		seqNum = bufUser->GetUserSeqNum();
	}
	
	UINT nCmdId = CMD_TXTMSG;
	PMsgbuf pBuf = bufcache->GetBuffer();
	
	int ack = 1;
	PACKACK(pBuf, ack, 0);
	PACKCMD(pBuf, nCmdId);
	PACKSEQSUM(pBuf, seqNum);
	PACKADDR(pBuf, addr, port);
	PACKUSER(pBuf, selfId, nUserId);
	pBuf->len = PackHeaderSize;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += pBuf->len;

	int nSize = strMsg.size();
	PTextMsg chat = (PTextMsg)buf;
	
	WriteLog("chat to user = %d msg = %s size = %d", nUserId, strMsg.c_str(), nSize);

	chat->len = nSize;
	strcpy(chat->msg, strMsg.c_str());

	pBuf->len += TextMsgSize + nSize;

	CalcBufLen(pBuf);
	CheckSumVal(pBuf);

	CSendTask* pSendTask = new CSendTask();
	pSendTask->SetKeyId(nKeyId);
	pSendTask->SetUserId(nUserId);
	buftask->PushTask(pSendTask);

	pBuf->task = pSendTask;

	sendctrl->PushMsg(pBuf);
}

void SendEntFile(UINT nUserId, string fileName, string filePath)
{
	PUserCtrl user = bufUser->GetUserSelf();	
	
	UINT nCmdId = CMD_ENTFILESEND;
	PMsgbuf pBuf = bufcache->GetBuffer();
	
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;	
	
	PACKACK(pBuf, 1, 0);
	PACKSEQSUM(pBuf, 0);
	PACKCMD(pBuf, nCmdId);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += pBuf->len;

	PEntFileData file = (PEntFileData)buf;
	file->toUserId = nUserId;
	file->entId = 1;
	file->fileType = 1;
	strcpy(file->fileName, fileName.c_str());
	strcpy(file->filePath, filePath.c_str());
	
	pBuf->len += ChatFileDataSize;

	CalcBufLen(pBuf);
 	CheckSumVal(pBuf);

	sendentfile->PushMsg(pBuf);	
}

void SendChatFile(UINT nKeyId, UINT nUserId, string fileName, PBYTE data, UINT nSize)
{
	PUserCtrl user = bufUser->GetUserSelf();	
	
	UINT nCmdId = CMD_CHATFILESEND;
	PMsgbuf pBuf = bufcache->GetBuffer();
	
	UINT servaddr = user->netStatus.nInetAddr;
	UINT servport = user->netStatus.nInetPort;	
	
	PACKACK(pBuf, 1, 0);
	PACKSEQSUM(pBuf, 0);
	PACKCMD(pBuf, nCmdId);
	PACKADDR(pBuf, servaddr, servport);
	pBuf->len = PackHeaderSize;
	
	PBYTE buf = (PBYTE)pBuf->payload;
	buf += pBuf->len;
	
	PChatFileData file = (PChatFileData)buf;
	file->toUserId = nUserId;
	strcpy(file->fileName, fileName.c_str());
	file->size = nSize;
	file->data = data;

	pBuf->len += ChatFileDataSize;
	
	CalcBufLen(pBuf);
	CheckSumVal(pBuf);
	
	//////////////////////////////////////////
	CSendTask* pSendTask = new CSendTask();
	pSendTask->SetKeyId(nKeyId);
	pSendTask->SetUserId(nUserId);
	buftask->PushTask(pSendTask);

	pBuf->task = pSendTask;
	//////////////////////////////////////////

	sendchatfile->PushMsg(pBuf);	
}
