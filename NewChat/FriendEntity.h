//
//  FriendEntity.h
//  WorldTchChat
//
//  Created by Bourbon on 13-12-8.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface FriendEntity : BaseEntity

@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int friendId;
@property (nonatomic,assign) int userId;
@property (nonatomic,assign) int friendUserId;
@property (nonatomic,assign) int groupId;
@property (nonatomic,copy) NSString *noteName;

@end
