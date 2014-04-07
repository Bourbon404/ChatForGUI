//
//  BaseEntity.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity
@synthesize entType;

-(void)initWithType:(EntityType)type
{
    entType = type;
}
-(int)getEntId
{

}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{

}

@end
