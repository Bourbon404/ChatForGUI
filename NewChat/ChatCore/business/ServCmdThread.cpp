// ServCmdThread.cpp: implementation of the CServCmdThread class.
//
//////////////////////////////////////////////////////////////////////

#include "ServCmdThread.h"
#include "../ChatCoreMsg.h"
#include "../center/SysCenter.h"
#include "../ChatDefine.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CServCmdThread::CServCmdThread()
{
	m_strThreadName = SERVCMD;
}

CServCmdThread::~CServCmdThread()
{

}

SBOOL CServCmdThread::DoBusiness(PMsgbuf pBuf)
{
	UINT nCmdId = 0;  
	PARSECMD(pBuf, nCmdId);

	switch(nCmdId) 
	{
	case CMD_LOGRES :
		Login(pBuf);
		break;
		
	case CMD_PUSHFRIEND:
		DoPushFriend(pBuf);
		break;

// 	case CMD_CHATFILEREADY:
// 		ChatFileData(pBuf);
// 		break;

//	case CMD_CHATFILEFINISH:
//		FinishSendFile(pBuf);
// 		break;

	case CMD_TXTMSG:
		DoRecvTextMsg(pBuf);
		break;

	case CMD_FRIENDFINISH:
		DoFriendFinish(pBuf);
		break;
		
	case CMD_PUSHENTDATA:
		DoPushEntData(pBuf);
		break;
	}
	
	return TRUE;
}


void CServCmdThread::Login(PMsgbuf pBuf)
{
	WriteLog("Login return");

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;

	PLoginRes pLogres = (PLoginRes)buf;

	UINT nUserId = pLogres->nUserId;
	BOOL bGetFriend = pLogres->bGetFriend;
	if (pLogres->loginRes == LOGIN_SUCCESS)
	{
		WriteLog("Login ok = %d", nUserId);

		PUserCtrl user = bufUser->GetUserSelf();
		if (user)
		{
			UINT nOldUserId = user->userInfo.nUserId;

			user->userInfo.nUserId = nUserId;
			
			if(nUserId == 0)  bufUser->PushBufUser(user);

			BOOL bGetFriend = pLogres->bGetFriend;
			if (bGetFriend == FALSE)
			{
				user->netStatus.bNatOk = TRUE;
			}		
		}
	}

	WriteLog("User login res = %d", pLogres->loginRes);
	
	pBuf = bufcache->GetBuffer();
	buf = (PBYTE)pBuf->payload;

	struct LoginAct
	{
		int act;
		int what;
		int res;
		int userid;
		BOOL getFriend;
	};

	int size = sizeof(struct LoginAct);

	struct LoginAct *pAct = (struct LoginAct *)buf;
	pAct->act = ACTION_MSG;
	pAct->what = LOGIN_ACT;
	pAct->res = pLogres->loginRes;
	pAct->userid = nUserId;
	pAct->getFriend = bGetFriend;

	SendSysAction(ACTION_MSG, buf, size);

	bufcache->RelBuffer(pBuf);
}

void CServCmdThread::DoLookUser(PMsgbuf pBuf)
{

}

void CServCmdThread::DoPushFriend(PMsgbuf pBuf)
{
	UINT nDatRes = 0;
	PARSEDATADESC(pBuf, nDatRes);
	
	struct PushData
	{
		int act;
		int what;
		int type;
		int entid;
	};

	if (nDatRes == E_USERINFO)
	{
		UINT nSize = pBuf->len;
		pBuf->ptr = PackHeaderSize;
		
		PBYTE buf = (PBYTE)pBuf->payload;
		buf += pBuf->ptr;
		
		while (pBuf->ptr + UserEntSize <= nSize)
		{
			PUserEnt pUserEnt = (PUserEnt)buf;
			UINT nUserId = pUserEnt->userId;
			
			UINT nSelfId = 0;
			PUserCtrl user = NULL;

			PUserCtrl self = bufUser->GetUserSelf();			
			if (self)  nSelfId = self->userInfo.nUserId;

			if (nSelfId != nSelfId)
			{
				user = new UserCtrl;

				InitUserCtrl(user);
			}
			else
			{
				user = self;
			}			
			
			user->userInfo.nUserId = nUserId;
			user->userInfo.strUserName = pUserEnt->userName;
			user->userInfo.strNickName = pUserEnt->nickName;
			user->userInfo.strSignature = pUserEnt->signature;
			
			bufUser->PushBufUser(user);
			
			{
				PMsgbuf p = bufcache->GetBuffer();
				PBYTE data = (PBYTE)p->payload;

				int size = sizeof(struct PushData);

				struct PushData *pPush = (struct PushData *)data;
				pPush->act = DATA_MSG;
				pPush->what = DATA_NEWUPD;
				pPush->type = nDatRes;
				pPush->entid = pUserEnt->userId;

				PBYTE dataptr = data + size;
				memcpy(dataptr, buf, UserEntSize);
                
                WriteLog("Push user act = %d, type = %d userId = %d", DATA_NEWUPD, nDatRes, nUserId);

				size += UserEntSize;
                SendSysAction(DATA_MSG, data, size);

				bufcache->RelBuffer(p);
			}

			WriteLog("friend user id = %d name = %s", user->userInfo.nUserId, user->userInfo.strUserName.c_str());
			
			buf += UserEntSize;
			pBuf->ptr += UserEntSize;
		}
	}
	else if (nDatRes == E_FRIENDGROUP)
	{
		UINT nSize = pBuf->len;
		pBuf->ptr = PackHeaderSize;
		
		PBYTE buf = (PBYTE)pBuf->payload;
		buf += pBuf->ptr;
		
		while (pBuf->ptr + FriendGroupEntSize <= nSize)
		{
			PFriendGroupEnt pGroupEnt = (PFriendGroupEnt)buf;
			
			PFriendGroupCtrl pGroup = new FriendGroupCtrl;
			InitFriendGroupCtrl(pGroup);
			
            UINT nGroupId = pGroupEnt->groupId;
			pGroup->nGroupId = nGroupId;
			pGroup->nUserId = pGroupEnt->userId;
			
			pGroup->strGroupName = pGroupEnt->groupName;
			
			{
				PMsgbuf p = bufcache->GetBuffer();
				PBYTE data = (PBYTE)p->payload;

				int size = sizeof(struct PushData);

				struct PushData *pPush = (struct PushData *)data;
				pPush->act = DATA_MSG;
				pPush->what = DATA_NEWUPD;
				pPush->type = nDatRes;
				pPush->entid = pGroupEnt->groupId;

				PBYTE dataptr = data + size;
				memcpy(dataptr, buf, FriendGroupEntSize);

                
                WriteLog("Push group act = %d, type = %d userId = %d", DATA_NEWUPD, nDatRes, nGroupId);

                
				size += FriendGroupEntSize;
				SendSysAction(DATA_MSG, data, size);

				bufcache->RelBuffer(p);
			}

			WriteLog("group id = %d name = %s", pGroup->nGroupId, pGroup->strGroupName.c_str());
			
			buf += FriendGroupEntSize;
			pBuf->ptr += FriendGroupEntSize;
			
		}
	}
	else if (nDatRes == E_USERFRIEND)
	{
		UINT nSize = pBuf->len;
		pBuf->ptr = PackHeaderSize;
		
		PBYTE buf = (PBYTE)pBuf->payload;
		buf += pBuf->ptr;
		
		while (pBuf->ptr + FriendEntSize <= nSize)
		{
			PFriendEnt pFriendEnt = (PFriendEnt)buf;
			
			PFriendCtrl pFriend = new FriendCtrl;
			InitFriendCtrl(pFriend);
			
            UINT nFriendId = pFriendEnt->nFriendId;
			pFriend->nFriendId = nFriendId;
			pFriend->nUserId = pFriendEnt->nUserId;
			pFriend->nFriendUserId = pFriendEnt->nFriendUserId;
			pFriend->nGroupId = pFriendEnt->nGroupId;
			pFriend->strNoteName = pFriendEnt->noteName;
			
			WriteLog("friend user id = %d userId = %d", pFriend->nUserId, pFriend->nFriendUserId);

			{
				PMsgbuf p = bufcache->GetBuffer();
				PBYTE data = (PBYTE)p->payload;

				int size = sizeof(struct PushData);

				struct PushData *pPush = (struct PushData *)data;
				pPush->act = DATA_MSG;
				pPush->what = DATA_NEWUPD;
				pPush->type = nDatRes;
				pPush->entid = pFriendEnt->nFriendId;

				PBYTE dataptr = data + size;
				memcpy(dataptr, buf, FriendEntSize);
                
                
                WriteLog("Push friend act = %d, type = %d userId = %d", DATA_NEWUPD, nDatRes, nFriendId);


				size += FriendEntSize;
                SendSysAction(DATA_MSG, data, size);

				bufcache->RelBuffer(p);
			}

			buf += FriendEntSize;
			pBuf->ptr += FriendEntSize;			
		}
	}
}

void CServCmdThread::DoRecvTextMsg(PMsgbuf pBuf)
{
	UINT nUserId = 0;  UINT userId = 0;
	PARSEUSER(pBuf, nUserId, userId);

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;

	PTextMsg msg = (PTextMsg)buf;
	int len = msg->len;
	string strMsg = msg->msg;

	WriteLog("Recv msg from = %d msg = %s", nUserId, strMsg.c_str());

	PMsgbuf p = bufcache->GetBuffer();
	buf = (PBYTE)p->payload;

	struct RecvMsgAct
	{
		int act;
		int what;
		int userid;
		int size;
	};

	int size = sizeof(struct RecvMsgAct);

	struct RecvMsgAct *pAct = (struct RecvMsgAct *)buf;
	pAct->act = ACTION_MSG;
	pAct->what = RECVMSG_ACT;
	pAct->userid = nUserId;
	pAct->size = len;

	PBYTE data = buf + size;
	strcpy((char*)data, strMsg.c_str());

	size += len;
	//g_sysCenter.NotifyEventData(buf, size);

	bufcache->RelBuffer(p);
}

void CServCmdThread::DoFriendFinish(PMsgbuf pBuf)
{
	PUserCtrl user = bufUser->GetUserSelf();
	user->netStatus.bNatOk = TRUE;
	
	struct FriendsAct
	{
		int act;
		int what;
	};

	pBuf = bufcache->GetBuffer();
	PBYTE buf = (PBYTE)pBuf->payload;

	int size = sizeof(struct FriendsAct);

	struct FriendsAct *pAct = (struct FriendsAct *)buf;
	pAct->act = ACTION_MSG;
	pAct->what = FRIEND_ACT;

	//g_sysCenter.NotifyEventData(buf, size);

	bufcache->RelBuffer(pBuf);
}

void CServCmdThread::DoPushEntData(PMsgbuf pBuf)
{
	UINT nDatRes = 0;
 	PARSEDATADESC(pBuf, nDatRes);

	PBYTE buf = (PBYTE)pBuf->payload;
	buf += PackHeaderSize;

	struct PushData
	{
		int act;
		int what;
		int type;
		int entid;
	};

	if (nDatRes == E_VISTORENT)
	{
		PVisitorEnt pVoisor = (PVisitorEnt)buf;
		
		{
			PMsgbuf p = bufcache->GetBuffer();
			PBYTE data = (PBYTE)p->payload;

			int size = sizeof(struct PushData);

			struct PushData *pPush = (struct PushData *)data;
			pPush->act = DATA_MSG;
			pPush->what = DATA_NEWUPD;
			pPush->type = E_VISTORENT;
			pPush->entid = pVoisor->visitorId;

			PBYTE dataptr = data + size;
			memcpy(dataptr, buf, VisitorEnttSize);

            WriteLog("Push visitor act = %d, type = %d visitorId = %d", DATA_NEWUPD, nDatRes, pVoisor->visitorId);

			size += VisitorEnttSize;
//			g_sysCenter.NotifyEventData(data, size);

			bufcache->RelBuffer(p);
		}

		WriteLog("vistor VISTOR: %s,vistorId: %d,Place:%s",pVoisor->userName,pVoisor->visitorId,pVoisor->userPlace);
	}

	if (nDatRes == E_INQPRICE)
	{
		PInquiryEnt pInqu = (PInquiryEnt)buf;

		WriteLog("inprice name: %s,plac:%s,code:%s",pInqu->userName,pInqu->userPlace,pInqu->orderCode);

		{
			PMsgbuf p = bufcache->GetBuffer();
			PBYTE data = (PBYTE)p->payload;

			int size = sizeof(struct PushData);
			WriteLog("push data size=%d", size);

			struct PushData *pPush = (struct PushData *)data;
			pPush->act = DATA_MSG;
			pPush->what = DATA_NEWUPD;
			pPush->type = E_INQPRICE;
			pPush->entid = pInqu->inquiryId;

			PBYTE dataptr = data + size;
			memcpy(dataptr, buf, InquiryEntSize);

            WriteLog("Push visitor act = %d, type = %d keyId = %d", DATA_NEWUPD, nDatRes, pInqu->inquiryId);

            int msgsize = InquiryEntSize;
            WriteLog("inquiry data size=%d", msgsize);

			size += msgsize;
//			g_sysCenter.NotifyEventData(data, size);

			bufcache->RelBuffer(p);
		}
	}

	if (nDatRes == E_INQPRICEMSG)
	{
		PInquiryMsgEnt pPriceMsg = (PInquiryMsgEnt)buf;

		WriteLog("inmsg User: %d,msg: %s",pPriceMsg->isSelf,pPriceMsg->msg);

		{
			PMsgbuf p = bufcache->GetBuffer();
			PBYTE data = (PBYTE)p->payload;

			int size = sizeof(struct PushData);
			WriteLog("push data size=%d", size);

			struct PushData *pPush = (struct PushData *)data;
			pPush->act = DATA_MSG;
			pPush->what = DATA_NEWUPD;
			pPush->type = E_INQPRICEMSG;
			pPush->entid = pPriceMsg->inquiryId;

			PBYTE dataptr = data + size;
			memcpy(dataptr, buf, InquiryMsgEntSize);

			WriteLog("Push inquiry msg act = %d, type = %d keyId = %d", DATA_NEWUPD, nDatRes, pPriceMsg->inquiryId);

			int msgsize = InquiryMsgEntSize;
			WriteLog("inquiry data size=%d", msgsize);

			size += msgsize;
			WriteLog("push total data size=%d", size);
//			g_sysCenter.NotifyEventData(data, size);

			bufcache->RelBuffer(p);
		}
 	}

	if (nDatRes == E_INQDETAIL)
	{
		PInqOrderDetailEnt pEnt = (PInqOrderDetailEnt)buf;

		WriteLog("inqury detail userId:%d, buyerId:%d,productName: %s,prodSellPrice:  %s",
					pEnt->userId,pEnt->buyerId,pEnt->productName,pEnt->prodSellPrice);

		{
			PMsgbuf p = bufcache->GetBuffer();
			PBYTE data = (PBYTE)p->payload;

			int size = sizeof(struct PushData);
			WriteLog("push data size=%d", size);

			struct PushData *pPush = (struct PushData *)data;
			pPush->act = DATA_MSG;
			pPush->what = DATA_NEWUPD;
			pPush->type = E_INQDETAIL;
			pPush->entid = pEnt->orderprdid;

			PBYTE dataptr = data + size;
			memcpy(dataptr, buf, InqOrderDetailEntSize);

			WriteLog("Push inqdetail act = %d, type = %d keyId = %d", DATA_NEWUPD, nDatRes, pEnt->orderprdid);

			int msgsize = InqOrderDetailEntSize;
			WriteLog("inquiry data size=%d", msgsize);

			size += msgsize;
			WriteLog("push total data size=%d", size);
//			g_sysCenter.NotifyEventData(data, size);

			bufcache->RelBuffer(p);
		}
 	}
}
