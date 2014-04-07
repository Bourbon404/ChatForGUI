//
//  BaseStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@implementation BaseStore
@synthesize allEnt,entType;

-(id)initWithType:(EntityType)type
{
    
    self = [super init];
    if (self != nil)
    {
        allEnt = [[NSMutableArray alloc] initWithCapacity:0];
        entType = type;
    }

    
    return self;
    
    

    
}
-(void)addEntity:(BaseEntity *)ent
{
    [allEnt addObject:ent];
}

-(void)deleteEntity:(BaseEntity *)ent
{
    [allEnt removeObject:ent];
}

-(BaseEntity *)findEntity:(int)entId
{
    return nil;
}

-(BOOL)isStore:(EntityType)type
{
    if (type == entType)
    {
        return YES;
    }
    return NO;
}

-(NSMutableArray *)getEntArray
{
    return allEnt;
}

-(void)removeAllEnt
{
    [allEnt removeAllObjects];
}


@end
