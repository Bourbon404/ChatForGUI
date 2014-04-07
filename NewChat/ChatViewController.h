//
//  ChatViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *chatTable;
    UITableView *chatGroupTable;
    NSMutableArray *chatPersonArray;
    
}
@property (nonatomic,assign) int userId;
@end
