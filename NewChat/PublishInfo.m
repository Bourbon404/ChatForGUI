//
//  PublishInfo.m
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "PublishInfo.h"
#include "SysInc.h"
@implementation PublishInfo
@synthesize ID,publishId,selfId,userId,userName,userPlace,shopId,shopName;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:PUBLISH_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}

-(void)DecodeEntData:(NSMutableData *)buf pos:(int)nPos
{
//    PublishEnt dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, PublishEntSize)];
//    
//    publishId = dataEnt.publishId;
//    selfId = dataEnt.selfId;
//    userId = dataEnt.userId;
//    userName = [NSString stringWithCString:dataEnt.userName encoding:NSUTF8StringEncoding];
//    userPlace = [NSString stringWithCString:dataEnt.userPlace encoding:NSUTF8StringEncoding];
//    shopId = dataEnt.shopId;
//    shopName = [NSString stringWithCString:dataEnt.shopName encoding:NSUTF8StringEncoding];
}


@end
