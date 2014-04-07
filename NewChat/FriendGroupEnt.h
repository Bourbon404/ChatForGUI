//
//  FriendGroupEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendGroupEnt : NSObject

@property (nonatomic,assign) int nGroupId;
@property (nonatomic,assign) int nUserId;
@property (nonatomic,copy) NSString *strGroupName;

@end
