//
//  UserAndMessageDatabase.h
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteDatabase.h"
#import "BaseEntity.h"
#import "MessageStore.h"

@class UserObject;
@class MessageObjective;
@class FriendEntity;
@class FriendGroupEntity;
@class OrderEnt;
@class InquiryEntity;
@class VistorInfo;
@class SMSInfo;

@interface UserAndMessageDatabase : NSObject
{
    SqliteDatabase *sqliteDatabase;
    
}
+(void) createDatabaseIfNotExists:(NSString *)username;
+(NSString *) filename:(NSString *)username;
+(UserAndMessageDatabase *) sharedDatabase;

@end

@interface UserAndMessageDatabase (Provider)

-(int)doInsert:(NSString *)sql;
-(int)doExeSql:(NSString *)sql;

// 具体的选择方法


-(void)selectAllRecentlyFriendsByUserId:(int)userId;
-(NSMutableArray *)selectAllFriendsByUserID:(int)UserID;
-(void)selectAllFriendGroupsByuserID:(int) userID;

-(NSMutableArray *)selectFriendByFriendGroupID:(int)friendGroupID andUserId:(int)UserID;

//选择聊天信息
-(void)selectNewByUserName:(NSString *)userName withFriend:(NSString *)friendName;

//business选择信息
-(void)selectSMSByUserID:(int) UserID;
-(void)selectOrderByUserID:(int) UserID;
-(void)selectInquiryByUserID:(int) UserID;
-(void)selectVistorByUserID:(int) UserID;
-(void)selectPublishByUPublishId:(int)publishId;

@end