//
//  UserStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface UserStore : BaseStore

@property (nonatomic,strong) UserStore *allUser;


-(BaseEntity *)createEnt;

-(void)addEntity:(UserObject *)ent;

-(int)addObjective:(UserObject *)aUser error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(UserObject *)aUser error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(UserObject *)aUser error:(NSError *__autoreleasing *)error;

@end
