//
//  OrderDeatEnt.m
//  mamachat
//
//  Created by bourbon on 14-1-20.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "OrderDeatEnt.h"
#include "SysInc.h"
@implementation OrderDeatEnt

@synthesize uOrderId,uBuyerId,uProdQty,uProdSellPrice,uProdSumPrice,uProductId,strProdFile,strProdFilePath,strProductName;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:ORDERDETAIL_ENT];
    }
    return self;
}
-(int)getEntId
{
    return uOrderId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    OrderDeatilEnt dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, OrderDeatilEntSize)];
//    
//    uOrderId = dataEnt.orderId;
//    uProductId = dataEnt.productId;
//    uBuyerId = dataEnt.buyerId;
//    strProductName = [NSString stringWithCString:dataEnt.productName encoding:NSUTF8StringEncoding];
//    uProdSellPrice = dataEnt.prodSellPrice;
//    uProdQty = dataEnt.prodQty;
//    uProdSumPrice = dataEnt.prodSumPrice;
}

@end
