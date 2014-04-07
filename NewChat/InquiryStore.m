//
//  InquiryStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "InquiryStore.h"
#import "InquiryEntity.h"
@implementation InquiryStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
       self = [self initWithType:INQUIRY_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    InquiryEntity *info = [[InquiryEntity alloc] init];
    return info;
}

-(int)addObjective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
#warning sql
    NSString *sql;
//    NSString * sql = [NSString stringWithFormat:@"insert into inquiry(headImg,bubbleNum,name,label,time,location,inquiryString,userID)values('%@',%d,'%@','%@','%@','%@','%@',%d);",aInquiry.headImg,aInquiry.bubbleNum,aInquiry.name,aInquiry.label,aInquiry.time,aInquiry.location,aInquiry.inquiryString,aInquiry.userID];
    
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aInquiry.inquiryId = lastRowId;
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
    [self addEntity:aInquiry];
    return rc;
}

-(int)deleeteObjective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from inquiry where ID=%i;",aInquiry.inquiryId];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(InquiryEntity *)aInquiry error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"update inquiry set bubbleNum = %d where ID = %i;",0,aInquiry.inquiryId];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(void)selectInquiryByUserId:(int)UserId
{
    [[UserAndMessageDatabase sharedDatabase] selectInquiryByUserID:UserId];
}

@end
