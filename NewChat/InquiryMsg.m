//
//  InquiryMsg.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "InquiryMsg.h"
#include "SysInc.h"
@implementation InquiryMsg

@synthesize inquiryId,msg,isSelf,inquiryTime;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:INQUIRYMSG_ENT];
    }
    return self;
}
-(int)getEntId
{
    return inquiryId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    InquiryMsgEnt dataEnt;
    [buf getBytes:&dataEnt range:NSMakeRange(nPos, InquiryMsgEntSize)];

    inquiryId = dataEnt.inquiryId;
    msg = [NSString stringWithCString:dataEnt.msg encoding:NSUTF8StringEncoding];
    isSelf = dataEnt.isSelf;
    inquiryTime = [NSString stringWithCString:dataEnt.inquiryTime encoding:NSUTF8StringEncoding];
}

@end
