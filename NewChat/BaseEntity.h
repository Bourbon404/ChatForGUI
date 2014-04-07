//
//  BaseEntity.h
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatDefine.h"
@interface BaseEntity : NSObject


@property (nonatomic) EntityType entType;

-(void)initWithType:(EntityType)type;

-(int)getEntId;

-(void)DecodeEntData:(NSMutableData*)buf pos: (int)nPos;

@end
