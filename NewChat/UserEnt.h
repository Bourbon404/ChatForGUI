//
//  UserEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEnt : NSObject

@property (nonatomic,assign) int userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *signature;
@property (nonatomic,copy) NSString *headerFile;
@property (nonatomic,copy) NSString *headerFilePath;

@end
