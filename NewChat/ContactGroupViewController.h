//
//  ContactGroupViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *buttonDic;
    NSMutableArray *titleArray;
    NSMutableDictionary *allFriednDic;
}
@property (nonatomic,strong) UITableView *groupTable;
//@property (nonatomic,strong) NSMutableArray *allFriendsArray;
@property (nonatomic,assign) int userID;
@end
