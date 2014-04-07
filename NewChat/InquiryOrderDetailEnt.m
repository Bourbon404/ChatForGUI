//
//  InquiryOrderDetailEnt.m
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "InquiryOrderDetailEnt.h"
#include "SysInc.h"
@implementation InquiryOrderDetailEnt

@synthesize inquiryId,orderId,productId,buyerId,productName,prodSellPrice,prodQty,prodSumPrice,prodFile,prodFilePath;

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:INQUIRYORDERDETAIL_ENT];
    }
    return self;
}
-(int)getEntId
{
    return inquiryId;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
//    InqOrderDeatilEnt dataEnd;
//    [buf getBytes:&dataEnd range:NSMakeRange(nPos, InqOrderDeatilEntSize)];
//    inquiryId = dataEnd.inquiryId;
//    orderId = dataEnd.orderId;
//    buyerId = dataEnd.buyerId;
//    productName = [NSString stringWithCString:dataEnd.productName encoding:NSUTF8StringEncoding];
//    prodSellPrice = dataEnd.prodSellPrice;
//    prodQty = dataEnd.prodQty;
//    prodSumPrice = dataEnd.prodSumPrice;
//    prodFile = [NSString stringWithCString:dataEnd.ProdFile encoding:(NSUTF8StringEncoding)];
    
}




@end
