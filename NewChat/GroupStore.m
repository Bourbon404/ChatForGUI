//
//  GroupStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "GroupStore.h"
#import "FriendGroupEntity.h"
@implementation GroupStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
       self = [self initWithType:GROUP_ENT];
    }
    return self;
}

-(BaseEntity *)createEnt
{
    FriendGroupEntity *group = [[FriendGroupEntity alloc] init];
    return group;
}

-(int)addObjective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString * sql = [NSString stringWithFormat:@"insert into FriendGroup(groupID, userID, groupName)values(%i,%i,'%@');",aFriendGroup.groupID,aFriendGroup.userID,aFriendGroup.groupName];
    
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aFriendGroup.ID = lastRowId;
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
    [self addEntity:aFriendGroup];
    return rc;
}

-(int)deleeteObjective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from FriendGroup where ID=%i;",aFriendGroup.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(FriendGroupEntity *)aFriendGroup error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"update FriendGroup set groupID = %i, userID = %i,groupName = '%@' where ID = %i;",aFriendGroup.groupID,aFriendGroup.userID,aFriendGroup.groupName,aFriendGroup.ID];
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    return rc;
}

-(void)selectGroupByUserId:(int)UserId
{
    [[UserAndMessageDatabase sharedDatabase] selectAllFriendGroupsByuserID:UserId];
}

@end
