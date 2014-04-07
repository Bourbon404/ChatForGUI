//
//  ContactAllViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactAllViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *allFriendsArray;
    UITableView *newFriendTable;
    UITableView *allFriendsTable;
    NSMutableArray *keyArray;
    
    
    NSMutableDictionary *allDic;
    
}
@property (nonatomic,assign) int userID;
//@property (nonatomic,strong) NSMutableArray *allFriendsArray;
//@property (nonatomic,strong) UITableView *newFriendTable;
//@property (nonatomic,strong) UITableView *allFriendsTable;

@end
