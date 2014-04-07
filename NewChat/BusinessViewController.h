//
//  BusinessViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *listTable;
    
    NSMutableArray *menuArray;
    NSMutableArray *menuControllerArray;
}

@property (nonatomic,assign) int userID;
@property (nonatomic,assign) int friendID;

@end
