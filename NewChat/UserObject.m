//
//  UserObject.m
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "UserObject.h"
#include "SysInc.h"

@implementation UserObject

@synthesize ID,userId,userName,userNickName,signNature,headFileName;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:USER_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    UserEnt dataent;
    
    [buf getBytes:&dataent range:NSMakeRange(nPos, UserEntSize)];
    
    userId = dataent.userId;
    userName = [NSString stringWithCString:dataent.userName encoding:NSUTF8StringEncoding];
    userNickName = [NSString stringWithCString:dataent.nickName encoding:NSUTF8StringEncoding];
    signNature = [NSString stringWithCString:dataent.signature encoding:NSUTF8StringEncoding];

}

@end
