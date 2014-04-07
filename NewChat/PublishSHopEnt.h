//
//  PublishSHopEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@interface PublishSHopEnt : BaseEntity

@property (nonatomic,assign) int publishId;
@property (nonatomic,assign) int selfId;
@property (nonatomic,assign) int userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userPlace;
@property (nonatomic,copy) NSString *userHeadFile;
@property (nonatomic,copy) NSString *userHeadFilePath;
@property (nonatomic,assign) int shopId;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *shopFile;
@property (nonatomic,copy) NSString *shopPath;

@end
