//
//  ChatAdapter.m
//  ChatCore
//
//  Created by Bourbon on 13-12-13.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#include "ChatUses.h"
#include "ChatDefine.h"
#import "ChatAdapter.h"

@implementation ChatAdapter

@synthesize delegate;

- (void) OnRecvChatNotify: (NSDictionary*)dict
{
    NSNumber* type = [dict objectForKey:@MSGTYPE];
    NSNumber* size = [dict objectForKey:@MSGSIZE];
    NSMutableData* buf = [dict objectForKey:@MSGDATA];
    
    
    int nType = [type intValue];
    int nSize = [size intValue];
    
    if (nType == DATA_MSG)
    {
        if (delegate != nil) [delegate DoEventData:buf bufsize:nSize];
    }
    else if (nType == ACTION_MSG)
    {
        if (delegate != nil)  [delegate DoEventAction:buf bufsize:nSize];
    }
}

+(void)Logout
{
    
}

+(void)ReleaseChatCore
{
    ReleaseCenter();
}

+(void)GetAllFriends
{
    
}

+(void)SyncAllFriends
{
    
}

+(void)BeginChatCore:(NSString*)strServAddr
{
    const char *  addr = [strServAddr UTF8String];
    
    BeginServCenter(addr);
}

+(void)IntFriend:(NSMutableData*)pBuf size:(int)nSize
{
    
}

+(void)InitChatCore:(NSString*)strIPAddr mask:(NSString*)strMask
{
    const char *  mask = [strMask UTF8String];
    const char *  ipaddr = [strIPAddr UTF8String];
    
    SetLocalAddr(mask, ipaddr);
}

+(void)Login:(BOOL)bGetFriend user: (NSString*)strUserName pwd:(NSString*)strPassword
{
    const char *  user = [strUserName UTF8String];
    const char *  password = [strPassword UTF8String];
   
    DoUserLogin(bGetFriend, user, password);
}

+(void)Relogin:(NSString*)strUserName pwd:(NSString*)strPassword
{
    
}

+(void)RequestChat:(int)nUserId
{
    
}

+ (void)SendTextMsg:(int)nKeyId user:(int)nToUserId msg:(NSString*)strMsg
{
    
}

+(void)DoChatBusiness:(int)nToUserId buf:(NSMutableData*)pBuf size:(int)nSize
{
    
}

+(void)SendFile:(int)nToUserId filename:(NSString*)strFileName buf:(NSMutableData*)pBuf size:(int)nSize
{
    
}

@end
