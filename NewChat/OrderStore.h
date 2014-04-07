//
//  OrderStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface OrderStore : BaseStore
-(BaseEntity *)createEnt;

-(int)addObjective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error;

-(void)selectOrderByUserId:(int)UserId;

@end
