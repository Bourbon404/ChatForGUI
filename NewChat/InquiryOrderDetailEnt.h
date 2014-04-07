//
//  InquiryOrderDetailEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@interface InquiryOrderDetailEnt : BaseEntity

@property (nonatomic,assign) int inquiryId;
@property (nonatomic,assign) int orderId;
@property (nonatomic,assign) int productId;
@property (nonatomic,assign) int buyerId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,assign) int prodSellPrice;
@property (nonatomic,assign) int prodQty;
@property (nonatomic,assign) int prodSumPrice;
@property (nonatomic,copy) NSString *prodFile;
@property (nonatomic,copy) NSString *prodFilePath;

@end
