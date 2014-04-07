//
//  DataStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "DataStore.h"
#import "UserStore.h"
#import "FriendStore.h"
#import "GroupStore.h"
#import "MessageStore.h"

#import "SMSStore.h"
#import "InquiryStore.h"
#import "OrderStore.h"
#import "VistorStore.h"

#import "RecentStore.h"

@implementation DataStore
@synthesize allStore;
-(id)init
{
    
    self = [super init];
    if (self != nil)
    {
        allStore = [[NSMutableArray alloc] init];
        
        BaseStore *store;
        store = [[UserStore alloc] init];
        [allStore addObject:store];
        
        store = [[FriendStore alloc] init];
        [allStore addObject:store];
        
        store = [[GroupStore alloc] init];
        [allStore addObject:store];
        
        store = [[MessageStore alloc] init];
        [allStore addObject:store];
        
        store = [[RecentStore alloc] init];
        [allStore addObject:store];
        
        store = [[SMSStore alloc] init];
        [allStore addObject:store];
        
        store = [[InquiryStore alloc] init];
        [allStore addObject:store];
        
        store = [[OrderStore alloc] init];
        [allStore addObject:store];
        
        store = [[VistorStore alloc] init];
        [allStore addObject:store];

    }
    
    return self;
}


-(BaseStore *)getStore:(EntityType)_type
{
    for (BaseStore *store in allStore)
    {
        if ([store isStore:_type])
        {
            return store;
        }
    }
    return nil;
}


@end
