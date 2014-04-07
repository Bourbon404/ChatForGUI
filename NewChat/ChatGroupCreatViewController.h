//
//  ChatGroupCreatViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatGroupCreatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITextField *searchField;
    IBOutlet UITableView *contactTable;
    
    NSMutableArray *contactPerson;
}
@end
