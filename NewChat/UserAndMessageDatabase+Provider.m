//
//  UserAndMessageDatabase+Provider.m
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "UserAndMessageDatabase.h"
#import "UserObject.h"
#import "MessageObjective.h"
#import "FriendEntity.h"
#import "FriendGroupEntity.h"
#import "SMSInfo.h"
#import "OrderEnt.h"
#import "InquiryEntity.h"
#import "VistorInfo.h"

#import "SMSInfo.h"
#import "OrderEnt.h"
#import "InquiryEntity.h"
#import "VistorInfo.h"
#import "PublishInfo.h"

@implementation UserAndMessageDatabase (Provider)


-(int)doInsert:(NSString *)sql
{
    int lastRowId;
    int rc = [sqliteDatabase executeNonQuery:sql outputLastInsertRowId:&lastRowId error:nil];
    if(rc == SQLITE_OK)
    {
        return  lastRowId;
    }
    return 0;
}
-(int)doExeSql:(NSString *)sql
{
    int rc = [sqliteDatabase executeNonQuery:sql error:nil];
    return rc;
}

//具体的选择方法
-(void)selectAllRecentlyFriendsByUserId:(int)userId
{
    NSString *sql = [NSString stringWithFormat:@"select * from Recently where userId = %i",userId];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    
    if (dr!=nil){
        while ([dr read]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore* store = [app.store getStore:RECENT_ENT];

            BaseEntity* ent = [store createEnt];
            FriendEntity *aFriend = (FriendEntity *)ent;
            
            aFriend.ID = [dr integerValueForColumnIndex:0];
            aFriend.friendId = [dr integerValueForColumnIndex:1];
            aFriend.userId = [dr integerValueForColumnIndex:2];
            aFriend.friendUserId = [dr integerValueForColumnIndex:3];
            aFriend.groupId = [dr integerValueForColumnIndex:4];
            aFriend.noteName = [dr stringValueForColumnIndex:5];
            
            [store addEntity:aFriend];
        }
        [dr close];
    }
    [sqliteDatabase close];
}


-(NSMutableArray *)selectAllFriendsByUserID:(int)UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from Friends where userID = %i",UserID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    NSMutableArray *array=[NSMutableArray array];
    if (dr!=nil){
        while ([dr read]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore *store = [app.store getStore:FRIEND_ENT];
            BaseEntity *ent = [store createEnt];
            FriendEntity *aFriend = (FriendEntity *)ent;
            
            aFriend.ID = [dr integerValueForColumnIndex:0];
            aFriend.friendId = [dr integerValueForColumnIndex:1];
            aFriend.userId = [dr integerValueForColumnIndex:2];
            aFriend.friendUserId = [dr integerValueForColumnIndex:3];
            aFriend.groupId = [dr integerValueForColumnIndex:4];
            aFriend.noteName = [dr stringValueForColumnIndex:5];
            
            [store addEntity:aFriend];
        }
        [dr close];
    }
    [sqliteDatabase close];
    
    return array;
}
-(void)selectAllFriendGroupsByuserID:(int) userID
{
    NSString *sql = [NSString stringWithFormat:@"select * from FriendGroup where userid = %i",userID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    if (dr!=nil){
        while ([dr read]) {
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore *store = [app.store getStore:GROUP_ENT];
            BaseEntity *ent = [store createEnt];
            FriendGroupEntity *aFriendGroup = (FriendGroupEntity *)ent;
            
            aFriendGroup.ID = [dr integerValueForColumnIndex:0];
            aFriendGroup.groupID = [dr integerValueForColumnIndex:1];
            aFriendGroup.userID = [dr integerValueForColumnIndex:2];
            aFriendGroup.groupName = [dr stringValueForColumnIndex:3];
            
            [store addEntity:aFriendGroup];
        }
        [dr close];
    }
    [sqliteDatabase close];
}
-(NSMutableArray *)selectFriendByFriendGroupID:(int)friendGroupID andUserId:(int)UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from friends where groupid = %i and userId = %i;",friendGroupID,UserID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (dr!=nil){
        while ([dr read])
        {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore *store = [app.store getStore:FRIEND_ENT];
            BaseEntity *ent = [store createEnt];
            FriendEntity *aFriend = (FriendEntity *)ent;

            aFriend.ID = [dr integerValueForColumnIndex:0];
            aFriend.friendId = [dr integerValueForColumnIndex:1];
            aFriend.userId = [dr integerValueForColumnIndex:2];
            aFriend.friendUserId = [dr integerValueForColumnIndex:3];
            aFriend.groupId = [dr integerValueForColumnIndex:4];
            aFriend.noteName = [dr stringValueForColumnIndex:5];
            
            [array addObject:aFriend];
        }
        [dr close];
    }
    [sqliteDatabase close];
    return array;
}

-(void)selectNewByUserName:(NSString *)userName withFriend:(NSString *)friendName
{
    NSString *sql = [NSString stringWithFormat:@"select * from news where messageFrom = '%@' and messageTo = '%@' or messageFrom = '%@' and messageTo = '%@';",userName,friendName,friendName,userName];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    MessageStore *store = (MessageStore *)[app.store getStore:MESSAGE_ENT];
    [store removeAllEnt];
    
    
    if (dr!=nil){
        while ([dr read]) {
            
            BaseEntity *ent = [store createEnt];
            MessageObjective *aMessage = (MessageObjective *)ent;
            
            aMessage.messageID = [dr integerValueForColumnIndex:0];
            aMessage.messageType = [dr stringValueForColumnIndex:1];
            aMessage.messageFrom = [dr stringValueForColumnIndex:2];
            aMessage.messageTo = [dr stringValueForColumnIndex:3];
            aMessage.messageContent = [dr stringValueForColumnIndex:4];
            aMessage.messageDate = [dr integerValueForColumnIndex:5];
            aMessage.isSend = [dr stringValueForColumnIndex:6];

            
            [store addEntity:aMessage];
        }
        [dr close];
    }
    [sqliteDatabase close];
}

-(void)selectSMSByUserID:(int) UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from sms where userID = %d;",UserID];
    [sqliteDatabase open];
//    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
//    if (dr!=nil){
//        while ([dr read]) {
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            BaseStore *store = [app.store getStore:SMS_ENT];
//            BaseEntity *ent = [store createEnt];
//            SMSInfo *sms = (SMSInfo *)ent;
//            
//            NSString *imageString = [dr stringValueForColumnIndex:1];
//            sms.headImg = [UIImage imageWithContentsOfFile:imageString];
//            sms.bubbleNum = [dr integerValueForColumnIndex:2];
//            sms.name = [dr stringValueForColumnIndex:3];
//            sms.time = [dr stringValueForColumnIndex:4];
//            sms.location = [dr stringValueForColumnIndex:5];
//            [store removeAllEnt];
//
//
//            [store addEntity:sms];
//
//        }
//        [dr close];
//    }
    [sqliteDatabase close];
}
-(void)selectOrderByUserID:(int) UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from OrderTable where userID = %d;",UserID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    if (dr!=nil){
        while ([dr read]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore *store = [app.store getStore:ORDER_ENT];
            BaseEntity *ent = [store createEnt];
            OrderEnt *order = (OrderEnt *)ent;
            order.headFile = [dr stringValueForColumnIndex:1];
            order.userName = [dr stringValueForColumnIndex:2];
            order.orderCode = [dr stringValueForColumnIndex:3];
            order.orderTime = [dr stringValueForColumnIndex:4];
            order.userPlace = [dr stringValueForColumnIndex:5];
            order.buyerId = [dr integerValueForColumnIndex:6];
            
            [store removeAllEnt];

            [store addEntity:order];
        }
        [dr close];
    }
    [sqliteDatabase close];
}
-(void)selectInquiryByUserID:(int) UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from inquiry where userID = %d;",UserID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    if (dr!=nil){
        while ([dr read]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            BaseStore *store = [app.store getStore:INQUIRY_ENT];
            BaseEntity *ent = [store createEnt];
            InquiryEntity *inquiry = (InquiryEntity *)ent;
            inquiry.filePath = [dr stringValueForColumnIndex:1];
            inquiry.userId = [dr integerValueForColumnIndex:2];
            inquiry.userName = [dr stringValueForColumnIndex:3];
            inquiry.fileName = [dr stringValueForColumnIndex:4];
//            inquiry. = [dr stringValueForColumnIndex:5];
            inquiry.userPlace = [dr stringValueForColumnIndex:6];
            inquiry.orderCode = [dr stringValueForColumnIndex:7];
          
            [store removeAllEnt];

            [store addEntity:inquiry];
        }
        [dr close];
    }
    [sqliteDatabase close];
}
-(void)selectPublishByUPublishId:(int)publishId
{
    NSString *sql = [NSString stringWithFormat:@"select * from publish where publishId = %d;",publishId];
    [sqliteDatabase open];
//    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
//    if (dr != nil)
//    {
//        while ([dr read])
//        {
//            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            BaseStore *store = [app.store getStore:PUBLISH_ENT];
//            BaseEntity *ent = [store createEnt];
//            PublishInfo *publish = (PublishInfo *)ent;
//            publish.ID = [dr integerValueForColumnIndex:0];
//            publish.publishId = [dr integerValueForColumnIndex:1];
//            publish.selfId = [dr integerValueForColumnIndex:2];
//            publish.userId = [dr integerValueForColumnIndex:3];
//            publish.userName = [dr stringValueForColumnIndex:4];
//            publish.userPlace = [dr stringValueForColumnIndex:5];
//            publish.shopId = [dr integerValueForColumnIndex:6];
//            publish.shopName = [dr stringValueForColumnIndex:7];
//            
//            [store removeAllEnt];
//            [store addEntity:publish];
//        }
//        [dr close];
//    }
    [sqliteDatabase close];
}
-(void)selectVistorByUserID:(int) UserID
{
    NSString *sql = [NSString stringWithFormat:@"select * from vistor where userID = %d;",UserID];
    [sqliteDatabase open];
    SqliteDataReader *dr = [sqliteDatabase executeQuery:sql];
    if (dr!=nil){
        while ([dr read]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            BaseStore *store = [app.store getStore:VISTOR_ENT];
            BaseEntity *ent = [store createEnt];
            VistorInfo *vistor = (VistorInfo *)ent;
            vistor.ID = [dr integerValueForColumnIndex:0];
            vistor.visitorId = [dr integerValueForColumnIndex:1];
            vistor.selfId = [dr integerValueForColumnIndex:2];
            vistor.UserId = [dr integerValueForColumnIndex:3];
            vistor.userName = [dr stringValueForColumnIndex:4];
            vistor.gender = [dr integerValueForColumnIndex:5];
            vistor.browseTime = [dr stringValueForColumnIndex:6];
            vistor.userPlace = [dr stringValueForColumnIndex:7];
            vistor.isCheck = [dr integerValueForColumnIndex:8];
            vistor.fileName = [dr stringValueForColumnIndex:9];
            vistor.filePath = [dr stringValueForColumnIndex:10];
            
//            NSString *imageString = [dr stringValueForColumnIndex:1];
//            vistor.headImg = [UIImage imageWithContentsOfFile:imageString];
//            vistor.isNew = [dr stringValueForColumnIndex:2];
//            vistor.name = [dr stringValueForColumnIndex:3];
//            vistor.sex = [dr stringValueForColumnIndex:4    ];
//            vistor.time = [dr stringValueForColumnIndex:5];
//            vistor.location = [dr stringValueForColumnIndex:6];
            
            [store addEntity:vistor];
        }
        [dr close];
    }
    [sqliteDatabase close];
}

@end
