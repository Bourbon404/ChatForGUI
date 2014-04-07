//
//  RecentStore.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface RecentStore : BaseStore
-(BaseEntity *)createEnt;

-(void)addEntity:(BaseEntity *)ent;


-(int)addObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error;

-(void)selectRecentlyByUserId:(int)UserId;

@end
