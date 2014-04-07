//
//  UserAndMessageDatabase.m
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "UserAndMessageDatabase.h"
#import "SqliteDatabase.h"

static UserAndMessageDatabase *staticUserAndMessageDatabase;
static NSString *userName;
@implementation UserAndMessageDatabase

+(void) createDatabaseIfNotExists:(NSString *)username
{
    userName = [NSString stringWithString:username];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *string1 = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),username];
    NSString *string2 = [NSString stringWithFormat:@"%@/Chat.sqlite",string1];
    if ([fileManager fileExistsAtPath:string2])
    {
        return;
    }
    else
    {
        [fileManager createDirectoryAtPath:string1 withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:string2 contents:nil attributes:nil];
    }
    
    NSMutableString *init_sqls = [NSMutableString stringWithCapacity:1024];
    [init_sqls appendFormat:@"create table user(ID integer primary key autoincrement, userId integer, userName text, userNickName text, signNature text, headFileName text);"];
    [init_sqls appendFormat:@"create table Friends(ID integer primary key autoincrement,friendId integer, userId integer,friendUserId integer,groupId integer, noteName text,headFileName text);"];
    [init_sqls appendFormat:@"create table FriendGroup(ID integer primary key autoincrement,groupID integer, userID integer,groupName text);"];
    
    [init_sqls appendFormat:@"create table News(messageID integer primary key autoincrement,messageType text,messageFrom text,messageTo text,messageContent text, messageDate integer,isSend text);"];
    [init_sqls appendFormat:@"create table Recently(ID integer primary key autoincrement,friendId integer, userId integer,friendUserId integer,groupId integer, noteName text);"];
    //创建business表
    [init_sqls appendFormat:@"create table SMS(ID integer primary key autoincrement,headImg text,bubbleNum integer,name text,time text,location text,userID integer);"];
    [init_sqls appendFormat:@"create table OrderTable(ID integer primary key autoincrement,headImg text,name text,OrderString text,time text,location text,userID integer);"];
    [init_sqls appendFormat:@"create table inquiry(ID integer primary key autoincrement,headImg text,bubbleNum integer,name text,label text,time text,location text,inquiryString text,userID integer);"];
    [init_sqls appendFormat:@"create table vistor(ID integer primary key autoincrement,visitorId integer,selfId integer, userId integer, userName text, gender integer, browseTime text,userPlace text, isCheck boolean,fileName text, filePath text);"];
    [init_sqls appendFormat:@"create table publish(ID integer primary key autoincrement, publishID integer, selfId integer,userID integer, username text,userPlace text, shopId integer, shopName text);"];
    
    
    
    
    
    //填写business数据
    NSString *imageString = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"];
    [init_sqls appendFormat:@"insert into SMS(ID,headImg,bubbleNum,name,time,location,userID)values(1,'%@',12,'雷昂那多','2013/10/10 pm 9:00','中国 深圳',2001);",imageString];
    [init_sqls appendFormat:@"insert into OrderTable(ID,headImg,name,OrderString,time,location,userID)values(1,'%@','雷昂那多','DR 123456','2013/10/10 pm 9:00','中国 深圳',2001);",imageString];
    [init_sqls appendFormat:@"insert into inquiry(ID,headImg,bubbleNum,name,label,time,location,inquiryString,userID)values(1,'%@',12,'雷昂那多','MP3 Player SD TF','2013/10/10 pm 9:00','中国 深圳','DF 4666',2001);",imageString];
    [init_sqls appendFormat:@"insert into vistor(ID ,visitorId ,selfId, userId , userName , gender , browseTime ,userPlace , isCheck ,fileName , filePath )values(1,1,1,1,'man',1,'2013-10-12','深圳',1,'file','fileName');"];
    
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1001, 2001, 3001, 0, 'qwe');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1002, 2001, 3002, 0, 'hued');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1003, 2001, 3003, 0, 'llcay');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1004, 2001, 3004, 0, 'superMan');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1005, 2001, 3005, 1, 'jrry');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1006, 2001, 3006, 1, 'ewq');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1007, 2001, 3007, 1, 'mamarow');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1008, 2001, 3008, 1, 'jikky');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1009, 2001, 3009, 2, 'www');"];
    [init_sqls appendFormat:@"insert into Friends(friendId, userId, friendUserId, groupId, noteName)values(1010, 2001, 3010, 2, 'hued2');"];
    
    
    NSString *file = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSString *name = [userDic objectForKey:@"username"];
    
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','qwe','%@','喂，在吗？？？','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','%@','qwe','订单号多少啊？请及时回信息','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','llcay','%@','jerry想加你为好友。。。。','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','%@','llcay','macbook pro md101多少钱啊，8000吗 能不能少点','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','jrry','%@','您好，租金能少点吗？','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','%@','jrry','我在车上，等会给你答复','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','mamarow','%@','hi，多少号？','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','%@','mamarow','你的手机多少啊','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','www','%@','我们晚上是不接受受理的，只有正常工作日才能这样办。','1388822522','yes');",name];
    [init_sqls appendFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('text','%@','www','hi，正如我轻轻的来','1388822522','yes');",name];
    
    [init_sqls appendFormat:@"insert into FriendGroup(groupID, userID, groupName)values(0,2001,'我的小学');"];
    [init_sqls appendFormat:@"insert into FriendGroup(groupID, userID, groupName)values(1,2001,'我的初中');"];
    [init_sqls appendFormat:@"insert into FriendGroup(groupID, userID, groupName)values(2,2001,'我的高中');"];
        
    SqliteDatabase *db = [[SqliteDatabase alloc] initWithFilename:[UserAndMessageDatabase filename:username]];
    [db executeNonQuery:init_sqls error:nil];
}
+(NSString *) filename:(NSString *)username
{
    NSString *str = [[NSString alloc] initWithFormat:@"%@/Documents/%@/Chat.sqlite",NSHomeDirectory(),username];
    return str;
}

+(UserAndMessageDatabase *) sharedDatabase
{
    if(staticUserAndMessageDatabase == nil)
    {
        staticUserAndMessageDatabase = [[UserAndMessageDatabase alloc] init];
    }
    return staticUserAndMessageDatabase;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        sqliteDatabase = [[SqliteDatabase alloc] initWithFilename:[UserAndMessageDatabase filename:userName]];
        
    }
    return self;
}
@end
