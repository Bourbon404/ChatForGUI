//
//  ChatGroupViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *chatGroupTable;

    NSMutableArray *groupArray;

    UIBarButtonItem *newGroup;
    UIBarButtonItem *doneGroup;
}
@end
