//
//  VistorStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface VistorStore : BaseStore
-(BaseEntity *)createEnt;

-(int)addObjective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error;

-(void)selectVistorByUserId:(int)UserId;

@end
