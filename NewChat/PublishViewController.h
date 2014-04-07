//
//  PublishViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *allButton;
    UIButton *productButton;
    UIButton *shopButton;
    UIButton *adverButton;
    
    UITableView *publishTable;
    NSMutableArray *publishArray;
    NSMutableDictionary *imageDic;
}
@end
