//
//  UserStore.m
//  mamachat
//
//  Created by bourbon on 14-1-13.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "UserStore.h"
#import "UserObject.h"
@implementation UserStore
@synthesize allUser;


-(id)init
{
    self = [super init];
    if (self != nil)
    {
        self = [self initWithType:USER_ENT];
    }
    return self;
}

-(BaseEntity *)createEnt
{
    UserObject *user = [[UserObject alloc] init];
    return user;
}

-(void)addEntity:(UserObject *)ent
{
    int i = 0;
    for (UserObject *tmp in self.allEnt)
    {
        if (ent == tmp)
        {
            i++;
        }
    }
    if (i == 0)
    {
        [self.allEnt addObject:ent];
    }
}




-(int)addObjective:(UserObject *)aUser error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString *sql = [NSString stringWithFormat:@"insert into user(userId, userName,userNickName, signNature, headFileName)values(%d,'%@','%@','%@','%@');",aUser.userId,aUser.userName,aUser.userNickName,aUser.signNature,aUser.headFileName];

    int rc = [[UserAndMessageDatabase sharedDatabase] doInsert:sql];
    
    int lastRowId;
    if (rc == SQLITE_OK)
    {
        aUser.ID = lastRowId;
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
    [self addEntity:aUser];
    return rc;
}
-(int)updateObjeective:(UserObject *)aUser error:(NSError *__autoreleasing *)error
{
    NSError *underlyingError;
    NSString *sql = [NSString stringWithFormat:@"update user set userId = %i, userName = '%@', userNickName = '%@', signNature = '%@', headFileName = '%@' where ID = %d;",aUser.userId,aUser.userName,aUser.userNickName,aUser.signNature,aUser.headFileName,aUser.ID];
    int rc = [[UserAndMessageDatabase sharedDatabase] doExeSql:sql];
    
    if(rc)
    {
        if(error!=NULL)
        {
            NSArray *objArray =[NSArray arrayWithObjects:@"更新用户失败",underlyingError, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,NSUnderlyingErrorKey, nil];
            NSDictionary *eDit = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
            *error = [[NSError alloc] initWithDomain:BUSINESS_ERROR_DOMAIN code:rc userInfo:eDit];
        }
    }
    
    for (UserObject *user in self.allEnt)
    {
        if(user.ID == aUser.ID)
        {
            user.ID= aUser.ID;
            user.userId = aUser.userId;
            user.userName = aUser.userName;
            user.userNickName = aUser.userNickName;
            user.signNature = aUser.signNature;
            user.headFileName = aUser.headFileName;
        }
    }
    
    return rc;

}
-(int)deleeteObjective:(UserObject *)aUser error:(NSError *__autoreleasing *)error
{
    return nil;
}

-(BaseEntity *)findEntity:(int)entId
{
    return nil;
}
@end
