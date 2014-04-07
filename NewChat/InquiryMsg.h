//
//  InquiryMsg.h
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@interface InquiryMsg : BaseEntity

@property (nonatomic,assign) int inquiryId;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) BOOL isSelf;
@property (nonatomic,copy) NSString *inquiryTime;

@end
