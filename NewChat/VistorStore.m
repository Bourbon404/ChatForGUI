//
//  VistorStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "VistorStore.h"
#import "VistorInfo.h"
@implementation VistorStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self = [self initWithType:VISTOR_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    VistorInfo *info = [[VistorInfo alloc] init];
    return info;
}

-(int)addObjective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString * sql = [NSString stringWithFormat:@"insert into vistor(visitorID,selfId,userId,userName,gender,browseTime,userPlace,isCheck,fileName,filePath)values(%d,%d,%d,'%@',%d,'%@','%@',%d,'%@','%@');",aVistor.visitorId,aVistor.selfId,aVistor.UserId,aVistor.userName,aVistor.gender,aVistor.browseTime,aVistor.userPlace,aVistor.isCheck,aVistor.fileName,aVistor.filePath];
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aVistor.ID = lastRowId;
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
    [self addEntity:aVistor];
    return rc;
}

-(int)deleeteObjective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from vistor where ID=%i;",aVistor.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(VistorInfo *)aVistor error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"update vistor where ID = %i;",aVistor.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(void)selectVistorByUserId:(int)UserId
{
    [[UserAndMessageDatabase sharedDatabase] selectVistorByUserID:UserId];
}

@end
