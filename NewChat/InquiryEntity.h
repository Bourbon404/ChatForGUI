//
//  InquiryEntity.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface InquiryEntity :BaseEntity

@property (nonatomic,assign) int inquiryId;
@property (nonatomic,assign) int selfId;
@property (nonatomic,assign) int userId;
@property (nonatomic,assign) int orderId;
@property (nonatomic,copy) NSString *orderCode;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,copy) NSString *userPlace;

@end
