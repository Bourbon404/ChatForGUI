//
//  ChatAdapter.h
//  ChatCore
//
//  Created by Bourbon on 13-12-13.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "EventDelegate.h"
#import <Foundation/Foundation.h>

@interface ChatAdapter : NSObject
{
    id<EventDelegate>  delegate;
}

@property (nonatomic, retain) id<EventDelegate>  delegate;

- (void) OnRecvChatNotify: (NSDictionary*)dict;

+ (void)Logout;
+ (void)ReleaseChatCore;
+ (void)GetAllFriends;
+ (void)SyncAllFriends;

+ (void)BeginChatCore:(NSString*)strServAddr;
+ (void)IntFriend:(NSMutableData*)pBuf size:(int)nSize;
+ (void)InitChatCore:(NSString*)strIPAddr mask:(NSString*)strMask;

+ (void)Login:(BOOL)bGetFriend user:(NSString*)strUserName pwd:(NSString*)strPassword;
+ (void)Relogin:(NSString*)strUserName pwd:(NSString*)strPassword;

+ (void)RequestChat:(int)nUserId;
+ (void)SendTextMsg:(int)nKeyId user:(int)nToUserId msg:(NSString*)strMsg;
+ (void)DoChatBusiness:(int)nToUserId buf:(NSMutableData*)pBuf size:(int)nSize;
+ (void)SendFile:(int)nToUserId filename:(NSString*)strFileName buf:(NSMutableData*)pBuf size:(int)nSize;

@end
