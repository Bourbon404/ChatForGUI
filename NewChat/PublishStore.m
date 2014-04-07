//
//  PublishStore.m
//  mamachat
//
//  Created by bourbon on 14-1-20.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "PublishStore.h"
#import "PublishInfo.h"
@implementation PublishStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//        self = [self initWithType:PUBLISH_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    PublishInfo *info = [[PublishInfo alloc] init];
    return info;
}

-(int)addObjective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString * sql = [NSString stringWithFormat:@"insert into publish(publishId,selfId,userId,userName,userPlace,shopId,shopName)values(%i,%i,%i,'%@','%@',%i,'%@');",aPublish.publishId,aPublish.selfId,aPublish.userId,aPublish.userName,aPublish.userPlace,aPublish.shopId,aPublish.shopName];
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aPublish.ID = lastRowId;
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
    [self addEntity:aPublish];
    return rc;
}

-(int)deleeteObjective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from publish where ID=%i;",aPublish.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(PublishInfo *)aPublish error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"update publish where ID = %i;",aPublish.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(void)selectPublishByPublishId:(int)publishId
{
    [[UserAndMessageDatabase sharedDatabase] selectPublishByUPublishId:publishId];
}
@end
