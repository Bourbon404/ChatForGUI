//
//  ContactNewFriendViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactNewFriendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *listTable;
    
    NSMutableArray *listArray;
}
-(IBAction)clickButton:(id)sender;
@end
