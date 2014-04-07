//
//  SMSInfo.m
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "SMSInfo.h"

@implementation SMSInfo
@synthesize ID,headImg,bubbleNum,name,time,location,userID;


-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:SMS_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    
}




-(NSString *)description
{
    return [NSString stringWithFormat:@"ID:%d,头像:%@,气泡数字:%d,用户名;%@,时间:%@,地点:%@,用户ID:%d",ID,headImg,bubbleNum,name,time,location,userID];
}
@end
