//
//  MessageStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"
#import "MessageObjective.h"
@interface MessageStore : BaseStore

-(BaseEntity *)createEnt;

-(void)addEntity:(MessageObjective *)ent;

-(int)addObjective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error;

-(void)selectMessageByUserName:(NSString *)userName withFriend:(NSString *)friendName;

@end
