//
//  ChatUses.h
//  ChatCore
//
//  Created by bourbon on 13-12-28.
//  Copyright (c) 2013年 bourbon. All rights reserved.
//

#ifndef _ChatUses_h
#define _ChatUses_h


void ReleaseCenter();
void BeginServCenter(const char* addr);
void SetLocalAddr(const char* mask, const char* ipaddr);

void DoUserLogin(BOOL bGetFriend, const char* user, const char* password);

#endif
