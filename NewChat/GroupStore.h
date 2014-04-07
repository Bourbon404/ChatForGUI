//
//  GroupStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface GroupStore : BaseStore
-(BaseEntity *)createEnt;


-(int)addObjective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error;

-(void)selectGroupByUserId:(int)UserId;

@end
