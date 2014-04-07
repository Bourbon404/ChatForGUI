//
//  PublishProdDetail.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "PublishProdDetail.h"
#include "SysInc.h"
@implementation PublishProdDetail

@synthesize publishId,productId,prodFile,prodFilePath,publishProdTime;
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:PUBLISHPRODDETAIL_ENT];
    }
    return self;
}
-(int)getEntId
{
    return publishId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    PublishProdEnt ÷dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, PublishProdEntSize)];
//    publishId = dataEnt.publishId;
//    productId = dataEnt.productId;
//    publishProdTime = [NSString stringWithCString:dataEnt.publishTime encoding:NSUTF8StringEncoding];
}


@end
