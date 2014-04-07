//
//  ChatMsgCenter.m
//  ChatCore
//
//  Created by Bourbon on 13-12-16.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatMsgCenter.h"
#include "ChatDefine.h"

@implementation ChatMsgCenter

-(void)SendChatMsg : (NSDictionary*)param
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    //发送notification
    [nc postNotificationName: @MSGCENTERNAME object:self userInfo:param];
}

@end
