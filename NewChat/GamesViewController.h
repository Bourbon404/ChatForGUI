//
//  GamesViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTable;
    NSMutableArray *listArray;
}
@end
