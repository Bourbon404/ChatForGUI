//
//  ContactViewController.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactAllViewController.h"
#import "ContactGroupViewController.h"
@interface ContactViewController : UIViewController
{
    ContactAllViewController *allFriendsTable;
    ContactGroupViewController *groupFriendsTable;
    
    NSMutableArray *contactArray;
    UISegmentedControl *segmentButton;
    int selectNum;
}

@property (nonatomic,assign) int userID;

@end
