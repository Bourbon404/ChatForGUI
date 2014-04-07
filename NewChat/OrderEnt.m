//
//  OrderEnt.m
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "OrderEnt.h"
#include "SysInc.h"

@implementation OrderEnt

@synthesize orderId,buyerId,userName,headFile,filePath,orderTime,userPlace,orderCode,goodsSum,totalPrice,isPay;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:ORDER_ENT];
    }
    return self;
}
-(int)getEntId
{
    return orderId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    UserOrderEnt dataEnt;
//    [buf getBytes:&dataEnt range:NSMakeRange(nPos, UserOrderEntSize)];
//    orderId = dataEnt.OrderId;
//    buyerId = dataEnt.BuyerId;
//    userName = [NSString stringWithCString:dataEnt.userName encoding:NSUTF8StringEncoding];
//    orderTime = [NSString stringWithCString:dataEnt.orderTime encoding:NSUTF8StringEncoding];
//    userPlace = [NSString stringWithCString:dataEnt.userPlace encoding:NSUTF8StringEncoding];
//    orderCode = [NSString stringWithCString:dataEnt.orderCode encoding:NSUTF8StringEncoding];
//    goodsSum = dataEnt.goodsSum;
//    totalPrice = dataEnt.totalPrice;
//    isPay = dataEnt.isPay;
}

@end
