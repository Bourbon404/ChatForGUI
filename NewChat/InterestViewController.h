//
//  InterestViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *productTable;
    UITableView *shopTable;
    
    UIButton *productButton;
    UIButton *shopButton;

    UIBarButtonItem *cleanButton;
    UIBarButtonItem *doneButton;
}

@property (nonatomic,strong) NSMutableArray *productArray;
@property (nonatomic,strong) NSMutableArray *shopArray;

@end
