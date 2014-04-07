//
//  OrderDeatEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-20.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@interface OrderDeatEnt : BaseEntity
@property (nonatomic,assign) int uOrderId;
@property (nonatomic,assign) int uProductId;
@property (nonatomic,assign) int uBuyerId;
@property (nonatomic,copy) NSString *strProductName;
@property (nonatomic,assign) int uProdSellPrice;
@property (nonatomic,assign) int uProdQty;
@property (nonatomic,assign) int uProdSumPrice;
@property (nonatomic,copy) NSString *strProdFile;
@property (nonatomic,copy) NSString *strProdFilePath;
@end
