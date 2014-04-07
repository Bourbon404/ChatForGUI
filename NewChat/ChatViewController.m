//
//  ChatViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"
#import "ChatGroupViewController.h"
#import "ChatGroupCreatViewCell.h"
#import "SearchVIew.h"
#import "ChatWithPeopleViewController.h"
#import "FriendEntity.h"
#import "RecentStore.h"
#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width



@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize userId;

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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.

    //准备数据
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    RecentStore *store = (RecentStore *)[app.store getStore:RECENT_ENT];
    [store selectRecentlyByUserId:userId];
    chatPersonArray = [[NSMutableArray alloc] initWithArray:[store getEntArray]];

    
    self.navigationItem.title = @"Chat";
    //ios7更改navigationbar上的字体颜色
    if (iOS7)
    {
        NSDictionary *barDIc = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:barDIc];
    }

    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44+68.5f)];
    //添加搜索框
    SearchVIew *searchView = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320,44)];
    searchView.backgroundColor = [UIColor clearColor];
    
    //点击添加群组的表格
    chatGroupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 68.5f) style:(UITableViewStylePlain)];
    chatGroupTable.delegate = self;
    chatGroupTable.dataSource = self;
    chatGroupTable.scrollEnabled = NO;
    chatGroupTable.separatorColor = [UIColor blackColor];
    chatGroupTable.backgroundColor = [UIColor clearColor];
    //调整ios7中的表格分割线不对齐问题
    if (iOS7)
    {
        [chatGroupTable setSeparatorInset:UIEdgeInsetsZero];
        //会话列表
        chatTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT-49) style:(UITableViewStylePlain)];
    }
    else
    {
        chatTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT) style:(UITableViewStylePlain)];
    }
    chatTable.separatorColor = [UIColor blackColor];
    chatTable.delegate = self;
    chatTable.dataSource = self;
    chatTable.backgroundColor = [UIColor clearColor];
    if (iOS7)
    {
        [chatTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([chatPersonArray count] == 0)
    {
        chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [headView addSubview:searchView];
    [headView addSubview:chatGroupTable];
    chatTable.tableHeaderView = headView;
    chatTable.backgroundColor = [UIColor clearColor];
    chatGroupTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:chatTable];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addChatPerson:) name:@"AddPerson" object:nil];
    
    //设置背景
    UIImage *backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    chatTable.backgroundView = [[UIImageView alloc] initWithImage:backImage];
    UIImage *naviImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"导航栏" ofType:@"png"]];
    if (!iOS7) {
        naviImg = [self scaleToSize:naviImg size:self.navigationController.navigationBar.bounds.size];
    }
    [self.navigationController.navigationBar setBackgroundImage:naviImg forBarMetrics:(UIBarMetricsDefault)];
}
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 动态添加聊天人
//动态添加聊天人
-(void)addChatPerson:(NSNotification *)notify
{
    FriendEntity *_friend = [notify object];
    int i=0;
    for (FriendEntity *aFriend in chatPersonArray)
    {
        if (aFriend == _friend)
        {
            i++;
        }
    }
    if (i == 0)
    {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
        RecentStore *store = (RecentStore *)[app.store getStore:RECENT_ENT];
        [store addObjective:_friend error:nil];
//        chatPersonArray = [store getEntArray];
        [chatPersonArray addObject:_friend];
    }
    [chatTable reloadData];
}
#pragma mark UITabelView Deleagete
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == chatTable)
    {
        return [chatPersonArray count];
    }
    else if (tableView == chatGroupTable)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    if (tableView == chatTable)
    {

        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil)
        {
            cell = [[ChatCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentify];
        }
        FriendEntity *_friend = [chatPersonArray objectAtIndex:indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.headImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
        if ([_friend.noteName isEqualToString:@""] || _friend.noteName == nil)
        {
            cell.nameLabel.text = [NSString stringWithFormat:@"%i",_friend.friendId];
        }
        else
        {
            cell.nameLabel.text = _friend.noteName;
        }
        
        cell.messageLabel.text = @"What are you doing";
        cell.dateLabel.text = @"PM 2:00";
        cell.numLabel.text = @"6";
        return cell;

    }
    else
    {
        ChatGroupCreatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil)
        {
            cell = [[ChatGroupCreatViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentify];
        }
        cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"群聊天" ofType:@"png"]];
        cell.messageLabel.text = @"聊天群";
        cell.nextButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == chatGroupTable)
    {
        ChatGroupViewController *chatGroup = [[ChatGroupViewController alloc] init];
        [self.navigationController pushViewController:chatGroup animated:YES];
    }
    else
    {
        FriendEntity *_friend = [chatPersonArray objectAtIndex:indexPath.row];
        ChatWithPeopleViewController *chat = [[ChatWithPeopleViewController alloc] init];
        chat.flag = @"聊天";
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        chat.userName = [userDefault objectForKey:@"username"];
        
        if ([_friend.noteName isEqualToString:@""] || _friend.noteName == nil)
        {
            chat.titleString = [NSString stringWithFormat:@"%i",_friend.friendId];
        }
        else
        {
            chat.titleString = _friend.noteName;
        }
    
        chat.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chat animated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == chatTable)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        FriendEntity *_friend = [chatPersonArray objectAtIndex:indexPath.row];
        [chatPersonArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
        
        
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
        BaseStore *store = [app.store getStore:RECENT_ENT];
        [store deleeteObjective:_friend error:nil];
      
        [chatTable reloadData];
    }
}
@end
