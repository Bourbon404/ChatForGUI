//
//  FriendEntity.m
//  WorldTchChat
//
//  Created by Bourbon on 13-12-8.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "FriendEntity.h"
#include "SysInc.h"

@implementation FriendEntity

@synthesize friendId,userId,friendUserId,groupId,noteName,ID;


-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:FRIEND_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    FriendEnt dataEnt;
    [buf getBytes:&dataEnt range:NSMakeRange(nPos, FriendEntSize)];
    
    friendId = dataEnt.nFriendId;
    userId = dataEnt.nUserId;
    friendUserId = dataEnt.nFriendUserId;
    groupId = dataEnt.nGroupId;
    noteName = [NSString stringWithCString:dataEnt.noteName encoding:NSUTF8StringEncoding];
}



-(NSString *)description
{
    return  [NSString stringWithFormat:@"friendID:%d,userID:%d,friendUserID:%d,groupId:%d,noteName:%@",friendId,userId,friendUserId,groupId,noteName];
}

@end
