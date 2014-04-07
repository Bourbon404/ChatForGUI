//
//  InquiryViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InquiryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate >
{
    UITableView *inquiryTable;
}
@property (nonatomic,strong) NSMutableArray *inquiryArray;
@property (nonatomic,assign) int userID;
@end
