//
//  ContactViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactCell.h"
#import "ContactNewFriendViewController.h"
#import "ChatGroupCreatViewCell.h"
#import "ChatWithPeopleViewController.h"
#import "FriendEntity.h"
#import "ChatViewController.h"
#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize userID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //上方的分段按钮
    segmentButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"分组",@"全部", nil]];
    segmentButton.frame = CGRectMake(110, 10, 100, 24);
    [segmentButton addTarget:self action:@selector(changeTable:) forControlEvents:(UIControlEventValueChanged)];
    segmentButton.selectedSegmentIndex = selectNum;
    [self.navigationController.navigationBar addSubview:segmentButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //全部好友
    allFriendsTable = [[ContactAllViewController alloc] init];
    allFriendsTable.userID = userID;
    allFriendsTable.view.backgroundColor = [UIColor clearColor];
    //分组好友
    groupFriendsTable = [[ContactGroupViewController alloc] init];
    groupFriendsTable.userID = userID;
    groupFriendsTable.view.backgroundColor = [UIColor clearColor];

    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])
    {
        allFriendsTable.view.frame = CGRectMake(0, 64, 320, self.view.frame.size.height);
        groupFriendsTable.view.frame = CGRectMake(0, 64, 320, self.view.frame.size.height);
    }
    else
    {
        allFriendsTable.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
        groupFriendsTable.view.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    }


    [self.view addSubview:allFriendsTable.view];
    [self.view addSubview:groupFriendsTable.view];

    
    allFriendsTable.view.hidden = YES;
    
    //设置背景
    self.view.backgroundColor = [UIColor clearColor];
    UIImage *naviImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"导航栏" ofType:@"png"]];
    if (!iOS7) {
        naviImg = [self scaleToSize:naviImg size:self.navigationController.navigationBar.bounds.size];
    }
    [self.navigationController.navigationBar setBackgroundImage:naviImg forBarMetrics:(UIBarMetricsDefault)];

    //消息中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatWithPeople:) name:@"chat" object:nil];
}
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
}
//分段选择器改变
-(void)changeTable:(id)sender
{
    allFriendsTable.view.hidden = NO;
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    int num = segment.selectedSegmentIndex;
    if (num == 0)
    {
        [allFriendsTable.view removeFromSuperview];
        [self.view addSubview:groupFriendsTable.view];
        [self.view reloadInputViews];
    }
    else
    {
        [groupFriendsTable.view removeFromSuperview];
        [self.view addSubview:allFriendsTable.view];
        [self.view reloadInputViews];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    selectNum = segmentButton.selectedSegmentIndex;
    [segmentButton removeFromSuperview];
    segmentButton = nil;
}
#pragma mark 接受消息后的方法
-(void)chatWithPeople:(NSNotification *)notify
{
    ChatWithPeopleViewController *chat = [[ChatWithPeopleViewController alloc] init];
    chat.flag = @"聊天";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    chat.userName = [userDefault objectForKey:@"username"];
    
    chat.hidesBottomBarWhenPushed = YES;
    
    FriendEntity *_friend = [notify object];
    if ([_friend.noteName isEqualToString:@""] || _friend.noteName == nil)
    {
        chat.titleString = [NSString stringWithFormat:@"%i",_friend.friendUserId];
    }
    else
    {
        chat.titleString = _friend.noteName;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddPerson" object:_friend];
    [self.navigationController pushViewController:chat animated:YES];
}

@end
