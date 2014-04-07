//
//  PublishSHopEnt.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "PublishSHopEnt.h"
#include "SysInc.h"
@implementation PublishSHopEnt

@synthesize publishId,selfId,userId,userName,userPlace,userHeadFile,userHeadFilePath,shopId,shopName,shopFile,shopPath;
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:PUBLISHSHOP_ENT];
    }
    return self;
}
-(int)getEntId
{
    return publishId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    PublishShopEnt dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, PublishShopEntSize)];
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
