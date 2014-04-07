//
//  SettingViewController.h
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *setTable;
    NSMutableArray *setArray;
}
@end
