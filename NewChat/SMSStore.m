//
//  SMSStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "SMSStore.h"
#import "SMSInfo.h"
@implementation SMSStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
//       self = [self initWithType:SMS_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    SMSInfo *sms = [[SMSInfo alloc] init];
    return sms;
}

-(int)addObjective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString * sql = [NSString stringWithFormat:@"insert into SMS(headImg,bubbleNum,name,time,location,userID)values('%@',%d,'%@','%@','%@',%d);",aSMS.headImg,aSMS.bubbleNum,aSMS.name,aSMS.time,aSMS.location,aSMS.userID];
    
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aSMS.ID = lastRowId;
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
    [self addEntity:aSMS];
    return rc;
}

-(int)deleeteObjective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from SMS where ID=%i;",aSMS.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(SMSInfo *)aSMS error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"update SMS set bubbleNum = %d where ID = %i;",aSMS.bubbleNum,aSMS.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(void)selectSMSByUserID:(int)UserID
{
    [[UserAndMessageDatabase sharedDatabase] selectSMSByUserID:UserID];
}


@end
