//
//  AppDelegate.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reachability.h"
#import "ChatAdapter.h"
#import "EventDelegate.h"

#import "DataStore.h"

#import "SqliteDatabase.h"

@class ChatViewController;
@class ContactViewController;
@class BusinessViewController;
@class ManagementViewController;
@class MeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,EventDelegate>
{
    Reachability *internetReachableFoo;
    
    ChatAdapter *chatB;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) ChatViewController *chat;
@property (nonatomic,strong) ContactViewController *contact;
@property (nonatomic,strong) BusinessViewController *business;
@property (nonatomic,strong) ManagementViewController *management;
@property (nonatomic,strong) MeViewController *me;

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passWord;

@property (nonatomic,strong) DataStore *store;
@property (nonatomic,strong) SqliteDatabase *sqliteDatabase;


@property (nonatomic,strong) UserAndMessageDatabase *database;

@end
