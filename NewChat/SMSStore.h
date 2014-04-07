//
//  SMSStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface SMSStore : BaseStore

-(BaseEntity *)createEnt;

-(int)addObjective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error;

-(void)selectSMSByUserID:(int)UserID;

@end
