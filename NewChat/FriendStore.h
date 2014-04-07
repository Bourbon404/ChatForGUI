//
//  FriendStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface FriendStore : BaseStore
-(BaseEntity *)createEnt;

-(int)addObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;

@end
