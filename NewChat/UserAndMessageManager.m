//
//  UserAndMessageManager.m
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "UserAndMessageManager.h"
#import "UserAndMessageDatabase.h"
#import "UserObject.h"
#import "MessageObjective.h"
#import "FriendEntity.h"
#import "FriendGroupEntity.h"

#import "SMSInfo.h"
#import "OrderEnt.h"
#import "InquiryEntity.h"
#import "VistorInfo.h"

static UserAndMessageManager *staticUserAndMessageManager;

@implementation UserAndMessageManager

+(UserAndMessageManager *)defaultManager
{
    if(staticUserAndMessageManager == nil)
    {
        staticUserAndMessageManager = [[UserAndMessageManager alloc] init];
    }
    return staticUserAndMessageManager;
}


//具体的选择方法


-(NSMutableArray *)selectAllFriendsByUserID:(int)userID
{
    if(allFriends == nil)
    {
        NSArray *array = [[UserAndMessageDatabase sharedDatabase] selectAllFriendsByUserID:userID];
        allFriends = [[NSMutableArray alloc] initWithArray:array];
    }
    return allFriends;
}

-(NSMutableArray *)selectFriendByGroupID:(int)groupID andUserID:(int)UserID
{
    NSMutableArray *array = [[UserAndMessageDatabase sharedDatabase] selectFriendByFriendGroupID:groupID andUserId:UserID];
    return array;
}

@end
