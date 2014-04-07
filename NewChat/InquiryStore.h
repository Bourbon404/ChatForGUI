//
//  InquiryStore.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseStore.h"

@interface InquiryStore : BaseStore
-(BaseEntity *)createEnt;


-(int)addObjective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error;
-(int)updateObjeective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error;
-(int)deleeteObjective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error;

-(void)selectInquiryByUserId:(int)UserId;

@end
