#ifndef _SYSCLIENT_H_
#define _SYSCLIENT_H_

#include "../include/SysInc.h"

void AddUserFriend(BOOL bSelf, UINT nUserId, string strUserName);

void UserLBS(int nSize, PBaseStaion pLbsInfo);

void UserPos(XPoint pt);

void GetAllFriend();

void LookArond();

void SendUserMsg(UINT nKeyId, UINT nUserId, string strMsg);

void DoUserLogin(BOOL bGetFriend, string strUserName, string strPassword);

void SendEntFile(UINT nUserId, string fileName, string filePath);

void SendChatFile(UINT nKeyId, UINT nUserId, string fileName, PBYTE pBuf, UINT nSize);


#endif
