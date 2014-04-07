//
//  SMSViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *smsTable;
}
@property (nonatomic,strong) NSMutableArray *smsArray;

@property (nonatomic,assign) int userID;
@property (nonatomic,assign) int friendID;

@end
