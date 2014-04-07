//
//  ProductEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductEnt : NSObject

@property (nonatomic,assign) int nUserId;
@property (nonatomic,assign) int uProductId;
@property (nonatomic,assign) int uShopId;
@property (nonatomic,assign) int uFriendUserId;
@property (nonatomic,copy) NSString *strFriendName;
@property (nonatomic,copy) NSString *strFriendHeadFile;
@property (nonatomic,copy) NSString *strFriendHeadFilePath;
@property (nonatomic,copy) NSString *strProductName;
@property (nonatomic,copy) NSString *strProductImgFile;
@property (nonatomic,copy) NSString *strProductImgFilePath;
@property (nonatomic,copy) NSString *strCreatedTime;
@property (nonatomic,copy) NSString *strCountryName;
@property (nonatomic,copy) NSString *strProvinceName;
@property (nonatomic,copy) NSString *strCityName;

@end
