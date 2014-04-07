//
//  OrderStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "OrderStore.h"
#import "OrderEnt.h"
@implementation OrderStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self = [self initWithType:ORDER_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    OrderEnt *info = [[OrderEnt alloc] init];
    return info;
}

-(int)addObjective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString *sql = nil;
#warning sql
//    NSString * sql = [NSString stringWithFormat:@"insert into OrderTable(headImg,name,OrderString,time,location,userID)values('%@','%@','%@','%@','%@',%d);",aOrder.headImg,aOrder.name,aOrder.orderString,aOrder.time,aOrder.location,aOrder.userID];
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aOrder.orderId = lastRowId;
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
    [self addEntity:aOrder];
    return rc;
}

-(int)deleeteObjective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from OrderTable where ID=%i;",aOrder.orderId];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(OrderEnt *)aOrder error:(NSError *__autoreleasing *)error
{
    return nil;
}

-(void)selectOrderByUserId:(int)UserId
{
    [[UserAndMessageDatabase sharedDatabase] selectOrderByUserID:UserId];
}
@end
