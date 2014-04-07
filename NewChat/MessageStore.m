//
//  MessageStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "MessageStore.h"
#import "MessageObjective.h"
@implementation MessageStore

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self = [self initWithType:MESSAGE_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    MessageObjective *message = [[MessageObjective alloc] init];
    return message;
}

-(void)addEntity:(MessageObjective *)ent
{
    [self.allEnt addObject:ent];
    
    int i=0;
    for (MessageObjective *tmp in self.allEnt)
    {
        if (ent == tmp)
        {
            i=1;
        }
    }
    if (i == 0)
    {
        [self.allEnt addObject:ent];
    }
}


-(int)addObjective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString *sql = [NSString stringWithFormat:@"insert into News(messageType,messageFrom,messageTo,messageContent,messageDate,isSend)values('%@','%@','%@','%@',%d,'%@');",aMessage.messageType,aMessage.messageFrom,aMessage.messageTo,aMessage.messageContent,aMessage.messageDate,aMessage.isSend];
    
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aMessage.messageID = lastRowId;
    }
    
    
    if (rc)
    {
        if (error != NULL)
        {
            NSArray *objArray = [NSArray arrayWithObjects:@"新建用户失败",underlyingError, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSUnderlyingErrorKey, nil];
            NSDictionary *eDic = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [[NSError alloc] initWithDomain:BUSINESS_ERROR_DOMAIN code:rc userInfo:eDic];
        }
        return rc;
    }
    [self addEntity:aMessage];
    return rc;
}
-(int)deleeteObjective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from News where messageID=%i;",aMessage.messageID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}
-(int)updateObjeective:(MessageObjective *)aMessage error:(NSError *__autoreleasing *)error
{
    return nil;
}

-(void)selectMessageByUserName:(NSString *)userName withFriend:(NSString *)friendName
{
    [[UserAndMessageDatabase sharedDatabase] selectNewByUserName:userName withFriend:friendName];
}
@end
