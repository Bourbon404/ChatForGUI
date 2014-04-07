//
//  InquiryEntity.m
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "InquiryEntity.h"
#include "SysInc.h"
@implementation InquiryEntity


@synthesize inquiryId,selfId,userId,orderId,orderCode,userName,filePath,fileName,userPlace;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:INQUIRY_ENT];
    }
    return self;
}

-(int)getEntId
{
    return inquiryId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    InquiryPriceEnt dataEnt;
//    
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, InquiryEntitySize)];
//
//    inquiryId = dataEnt.inquiryId;
//    selfId = dataEnt.selfId;
//    userId = dataEnt.userId;
//    orderId = dataEnt.orderId;
//    orderCode = [NSString stringWithCString:dataEnt.orderCode encoding:NSUTF8StringEncoding];
//    userName = [NSString stringWithCString:dataEnt.userName encoding:NSUTF8StringEncoding];
//    userPlace = [NSString stringWithCString:dataEnt.userPlace encoding:NSUTF8StringEncoding];
}


@end
