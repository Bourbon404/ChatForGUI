//
//  VistorInfo.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "VistorInfo.h"
#include "SysInc.h"
@implementation VistorInfo
@synthesize ID;
@synthesize visitorId,selfId,UserId,userName,gender,browseTime,userPlace,isCheck,fileName,filePath;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:VISTOR_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    VisitorEnt dataEnt;
    [buf getBytes:&dataEnt range:NSMakeRange(nPos, VisitorEnttSize)];


    visitorId = dataEnt.visitorId;
    selfId = dataEnt.selfId;
    UserId = dataEnt.userId;
    userName = [NSString stringWithCString:dataEnt.userName encoding:NSUTF8StringEncoding];
    gender = dataEnt.gender;
    browseTime = [NSString stringWithCString:dataEnt.browseTime encoding:NSUTF8StringEncoding];
    userPlace = [NSString stringWithCString:dataEnt.userPlace encoding:NSUTF8StringEncoding];
    isCheck = dataEnt.isCheck;

}


@end
