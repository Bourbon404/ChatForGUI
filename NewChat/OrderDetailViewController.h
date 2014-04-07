//
//  OrderDetailViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSString *titleString;
@property (nonatomic,copy) NSString *totalNum;
@property (nonatomic,copy) NSString *totalPrice;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *location;
@end