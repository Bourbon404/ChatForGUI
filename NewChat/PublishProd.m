//
//  PublishProd.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "PublishProd.h"
@implementation PublishProd

@synthesize publishId,selfId,userId,userName,userPlace,userHeadFile,userHeadFilePath,shopId,shopName;
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        [self initWithType:PUBLISHPROD_ENT];
    }
    return self;
}
-(int)getEntId
{
    return publishId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{

}

@end
