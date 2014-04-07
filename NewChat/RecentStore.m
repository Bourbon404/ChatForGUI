//
//  RecentStore.m
//  mamachat
//
//  Created by bourbon on 14-1-14.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "RecentStore.h"
#import "FriendEntity.h"
@implementation RecentStore
-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self = [self initWithType:RECENT_ENT];
    }
    return self;
}
-(BaseEntity *)createEnt
{
    FriendEntity *info = [[FriendEntity alloc] init];
    return info;
}


-(void)addEntity:(BaseEntity *)ent
{
    [self.allEnt addObject:ent];
}




-(int)addObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString *sql = [NSString stringWithFormat:@"insert into Recently(friendId, userId, friendUserId, groupId, noteName)values(%i, %i, %i, %d, '%@');",aFriend.friendId,aFriend.userId,aFriend.friendUserId,aFriend.groupId,aFriend.noteName];
    
    
    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aFriend.ID = lastRowId;
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
    [self addEntity:aFriend];
    return rc;
}

-(int)deleeteObjective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error
{
    NSString *sql = [NSString stringWithFormat:@"delete from Recently where ID=%i;",aFriend.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    return rc;
}

-(int)updateObjeective:(FriendEntity *)aFriend error:(NSError *__autoreleasing *)error
{
    return nil;
}

-(void)selectRecentlyByUserId:(int)UserId
{
    [[UserAndMessageDatabase sharedDatabase] selectAllRecentlyFriendsByUserId:UserId];
}

@end
