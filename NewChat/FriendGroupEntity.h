//
//  FriendGroupEntity.h
//  WorldTchChat
//
//  Created by Bourbon on 13-12-8.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface FriendGroupEntity : BaseEntity

@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int groupID;
@property (nonatomic,assign) int userID;
@property (nonatomic,copy) NSString *groupName;

@end
