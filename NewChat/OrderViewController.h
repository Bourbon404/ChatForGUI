//
//  OrderViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *OrderTable;
}
@property (nonatomic,strong) NSMutableArray *orderArray;
@property (nonatomic,assign) int userID;
@end
