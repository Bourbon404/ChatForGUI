//
//  VisitorViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *visitorTable;
}
@property (nonatomic,strong) NSMutableArray *visitorArray;
@property (nonatomic,assign) int userID;
@end
