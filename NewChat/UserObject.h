//
//  UserObject.h
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface UserObject :BaseEntity

@property (assign) int ID;

@property (nonatomic,assign) int userId;
@property (nonatomic,copy) NSString *userName;

@property (nonatomic,copy) NSString *userNickName;

@property (nonatomic,copy) NSString *signNature;

@property (nonatomic,copy) NSString *headFileName;

@end
