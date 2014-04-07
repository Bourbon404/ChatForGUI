//
//  OrderEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface OrderEnt : BaseEntity
@property (nonatomic,assign) int orderId;
@property (nonatomic,assign) int buyerId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *headFile;
@property (nonatomic,copy) NSString *filePath;
@property (nonatomic,copy) NSString *orderTime;
@property (nonatomic,copy) NSString *userPlace;
@property (nonatomic,copy) NSString *orderCode;
@property (nonatomic,assign) int goodsSum;
@property (nonatomic,assign) int totalPrice;
@property (nonatomic,assign) BOOL isPay;
@end
