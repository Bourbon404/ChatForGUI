//
//  MeViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@interface MeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    UIImageView *headImg;
    UIButton *button;
    UITableView *listTable;
    
    
    NSMutableArray *listArray;

    //位置相关
    CLLocationManager *location;
    
    NSString *fileString;

    
}
@end
