//
//  BaseStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import "ChatDefine.h"


@interface BaseStore : NSObject

@property (nonatomic) EntityType entType;
@property (nonatomic,strong) NSMutableArray *allEnt;
-(id)initWithType:(EntityType)type;

-(BOOL)isStore:(EntityType)type;

-(void)addEntity:(BaseEntity *)ent;

-(void)deleteEntity:(BaseEntity *)ent;


-(void)removeAllEnt;

-(BaseEntity *)findEntity:(int)entId;

-(NSMutableArray *)getEntArray;

-(BaseEntity *)createEnt;

-(int)addObjective:(BaseEntity *)entity error:(NSError **)error;
-(int)deleeteObjective:(BaseEntity *)entity error:(NSError **)error;
-(int)updateObjeective:(BaseEntity *)aEntity error:(NSError **)error;
@end
