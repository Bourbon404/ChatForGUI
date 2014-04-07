//
//  ChatUses.cpp
//  ChatCore
//
//  Created by bourbon on 13-12-28.
//  Copyright (c) 2013年 bourbon. All rights reserved.
//


#include "ChatUses.h"
#include "./center/SysCenter.h"

void ReleaseCenter()
{
    g_sysCenter.StopCenter();
}

void BeginServCenter(const char* addr)
{
    string strServAddr(addr);
    
    g_sysCenter.SetServerAddr(strServAddr);
    
    g_sysCenter.StartCenter();
}

void SetLocalAddr(const char* mask, const char* ipaddr)
{
    string strMask(mask);
    string strIpAddr(ipaddr);
  
    g_sysCenter.SetLocalMask(strMask);
    g_sysCenter.SetLocalAddr(strIpAddr);
    
}

void DoUserLogin(BOOL bGetFriend, const char* user, const char* password)
{
    string strUserName(user);
    string strPassword(password);
 
    DoUserLogin(TRUE, strUserName, strPassword);
}

