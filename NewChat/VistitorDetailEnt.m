//
//  VistitorDetailEnt.m
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "VistitorDetailEnt.h"
#include "SysInc.h"
@implementation VistitorDetailEnt
@synthesize ID;
@synthesize uShopId,nVisitorId,uProductId,strFilePath,strProductImg;
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:VISTORDETAIL_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos:(int)nPos
{
//    VisitorDetailEnt dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, NSUTF8StringEncoding)];
//    
//    nVisitorId = dataEnt.visitorId;
//    uProductId = dataEnt.productId;
    
}
@end
