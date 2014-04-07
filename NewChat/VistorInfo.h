//
//  VistorInfo.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface VistorInfo : BaseEntity

@property (nonatomic,assign) int ID;


@property (nonatomic,assign) int visitorId;
@property (nonatomic,assign) int selfId;
@property (nonatomic,assign) int UserId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,assign) int gender;
@property (nonatomic,copy) NSString *browseTime;
@property (nonatomic,copy) NSString *userPlace;
@property (nonatomic,assign) BOOL isCheck;
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *filePath;  

@end
