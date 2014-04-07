//
//  VistitorDetailEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VistitorDetailEnt : BaseEntity

@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int uShopId;
@property (nonatomic,assign) int nVisitorId;
@property (nonatomic,assign) int uProductId;
@property (nonatomic,copy) NSString *strProductImg;
@property (nonatomic,copy) NSString *strFilePath;

@end
