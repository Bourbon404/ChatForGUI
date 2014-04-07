//
//  PublishInfo.h
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved. 


#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface PublishInfo : BaseEntity

@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int publishId;
@property (nonatomic,assign) int selfId;
@property (nonatomic,assign) int userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPlace;
@property (nonatomic,assign) int shopId;
@property (nonatomic,copy) NSString *shopName;

@end
