//
//  MessageObjective.h
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
@interface MessageObjective : BaseEntity

@property (nonatomic,copy) NSString *messageType;
@property (assign) int messageID;
@property (nonatomic,copy) NSString *messageFrom;
@property (nonatomic,copy) NSString *messageTo;
@property (nonatomic,copy) NSString *messageContent;
@property (nonatomic,assign) int messageDate;
@property (nonatomic,copy) NSString *isSend;
@end
