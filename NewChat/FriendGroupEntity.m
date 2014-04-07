//
//  FriendGroupEntity.m
//  WorldTchChat
//
//  Created by Bourbon on 13-12-8.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "FriendGroupEntity.h"
#include "SysInc.h"
@implementation FriendGroupEntity

@synthesize groupID,userID,groupName,ID;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:GROUP_ENT];
    }
    return self;
}
-(int)getEntId
{
    return ID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    FriendGroupEnt dataEnt;
    [buf getBytes:&dataEnt range:NSMakeRange(nPos, FriendGroupEntSize)];
    
    groupID = dataEnt.groupId;
    userID = dataEnt.userId;
    groupName = [NSString stringWithCString:dataEnt.groupName encoding:NSUTF8StringEncoding];
}



-(NSString *)description
{
    return  [NSString stringWithFormat:@"groupId:%d,userID:%d,groupName:%@",groupID,userID,groupName];
}

@end
