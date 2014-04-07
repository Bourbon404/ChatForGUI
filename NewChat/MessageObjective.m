//
//  MessageObjective.m
//  WorldTchChat
//
//  Created by jerry deng on 13-10-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "MessageObjective.h"

@implementation MessageObjective

@synthesize messageType,messageID,messageFrom,messageTo,messageContent,messageDate,isSend;


-(id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initWithType:MESSAGE_ENT];
    }
    return self;
}
-(int)getEntId
{
    return messageID;
}
-(void)DecodeEntData:(NSMutableData *)buf pos: (int)nPos
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"messageType:%@,messageID:%d,messageFrom:%@,messageTo:%@,messageContent:%@,messageDate:%d,isSend:%@",messageType,messageID,messageFrom,messageTo,messageContent,messageDate,isSend];
}


@end
