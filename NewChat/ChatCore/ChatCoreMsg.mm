//
//  ChatMsgs.cpp
//  ChatCore
//
//  Created by bourbon on 13-12-28.
//  Copyright (c) 2013年 bourbon. All rights reserved.
//

#include "ChatDefine.h"
#include "ChatCoreMsg.h"
#import "ChatMsgCenter.h"
#import <Foundation/Foundation.h>

void SendSysAction(int event, unsigned char* pBuf, int nSize)
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithDictionary:0];
  
    NSNumber *type = [[NSNumber alloc] initWithInt:event];
    NSNumber *size = [[NSNumber alloc] initWithInt:nSize];
    NSMutableData *buf = [[NSMutableData alloc] initWithBytes:pBuf length:nSize];
    [dic setObject:type forKey:@MSGTYPE];
    [dic setObject:size forKey:@MSGSIZE];
    [dic setObject:buf forKey:@MSGDATA];
    
    ChatMsgCenter* center = [[ChatMsgCenter alloc] init];
    
    [center SendChatMsg:dic];
}