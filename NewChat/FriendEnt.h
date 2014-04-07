//
//  FriendEnt.h
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendEnt : NSObject

@property (nonatomic,assign) int nFriendId;
@property (nonatomic,assign) int nUserId;
@property (nonatomic,assign) int nFriendUserId;
@property (nonatomic,assign) int nGroupId;
@property (nonatomic,copy) NSString *strNoteName;

@end
