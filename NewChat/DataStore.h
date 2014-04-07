//
//  DataStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseStore.h"
@interface DataStore : NSObject

@property (nonatomic,strong) NSMutableArray *allStore;

-(id)init;

-(BaseStore *)getStore:(EntityType)_type;

@end
