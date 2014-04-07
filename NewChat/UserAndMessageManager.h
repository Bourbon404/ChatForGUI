//
//  UserAndMessageManager.h
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#define BUSINESS_ERROR_DOMAIN @"BUSINESS_ERROR_DOMAIN"

@class UserObject;
@class FriendEntity;
@class FriendGroupEntity;
@class MessageObjective;

@class SMSInfo;
@class OrderEnt;
@class InquiryEntity;
@class VistorInfo;

@interface UserAndMessageManager : NSObject
{
    NSMutableArray *allUser;
    NSMutableArray *allMessage;
    NSMutableArray *allFriends;
    NSMutableArray *allRecentlyFriends;
    NSMutableArray *allFriendGroups;
    
    //business
    NSMutableArray *allSMS;
    NSMutableArray *allOrder;
    NSMutableArray *allInquiry;
    NSMutableArray *allVistor;
}

+(UserAndMessageManager *)defaultManager;

//具体的选择方法


-(NSMutableArray *)selectAllFriendsByUserID:(int)userID;
-(NSMutableArray *)selectFriendByGroupID:(int)groupID andUserID:(int)UserID;


@end
