//
//  SMSInfo.h
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface SMSInfo : BaseEntity

@property (nonatomic,assign) int ID;
@property (nonatomic,strong) UIImage *headImg;
@property (nonatomic,assign) int bubbleNum;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,assign) int userID;
@end
