//
//  PublishStore.h
//  mamachat
//
//  Created by bourbon on 14-1-20.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"
#import "PublishInfo.h"
@interface PublishStore : BaseStore

-(BaseEntity *)createEnt;
-(int)addObjective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error;

-(void)selectPublishByPublishId:(int)publishId;

@end
