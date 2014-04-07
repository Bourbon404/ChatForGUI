//
//  VisitorDetail.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "VisitorDetail.h"

@implementation VisitorDetail

@synthesize visitorId,prodFile,prodFilePath,productId;

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
    return visitorId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{

}

@end
