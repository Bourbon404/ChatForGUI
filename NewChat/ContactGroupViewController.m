//
//  ContactGroupViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactGroupViewController.h"
#import "ContactCell.h"
#import "GroupButtonView.h"
#import "UserAndMessageManager.h"
#import "FriendGroupEntity.h"
#import "FriendEntity.h"
#import "SearchVIew.h"
#import "GroupStore.h"
@interface ContactGroupViewController ()

@end

@implementation ContactGroupViewController
@synthesize groupTable,userID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //搜索框
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    //分组表格
    if (iOS7) {
        groupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-64-49) style:(UITableViewStylePlain)];
    } else {
        groupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44-49) style:(UITableViewStylePlain)];
    }
    [groupTable setDelegate:self];
    [groupTable setDataSource:self];
    [groupTable setBackgroundColor:[UIColor clearColor]];
    [groupTable setSeparatorColor:[UIColor blackColor]];
    if (iOS7)
    {
        [groupTable setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [groupTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [groupTable setTableHeaderView:search];
    //去掉多余分割线
    [self setExtraCellLineHidden:groupTable];
    [self.view addSubview:groupTable];
    
    //准备数据
    buttonDic = [[NSMutableDictionary alloc] initWithDictionary:0];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    GroupStore *store = (GroupStore *)[app.store getStore:GROUP_ENT];
    [store selectGroupByUserId:userID];
    titleArray = [store getEntArray];
    
    
    
    
    allFriednDic  = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (FriendGroupEntity *group in titleArray)
    {
        NSMutableArray *array = [[UserAndMessageManager defaultManager] selectFriendByGroupID:group.groupID andUserID:userID];
        [allFriednDic setObject:array forKey:group.groupName];
    }
    
}
#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GroupButtonView *button = [buttonDic objectForKey:@(section)];
    if (button.isOpen == YES)
    {
        NSString *key = button.headLabel.text;
        return [[allFriednDic objectForKey:key] count];
    }
    else
    {
        return 0;
    }
}
//去除多余分割线
-(void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil)
    {
        cell = [[ContactCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentify];
    }
    NSString *key = [[allFriednDic allKeys] objectAtIndex:indexPath.section];
    NSMutableArray *array = [allFriednDic objectForKey:key];
    FriendEntity *_friend = [array objectAtIndex:indexPath.row];
    
    cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    if ([_friend.noteName isEqualToString:@""] || _friend.noteName == nil)
    {
        cell.nameLabel.text = [NSString stringWithFormat:@"%i",_friend.friendId];
    }
    else
    {
        cell.nameLabel.text = _friend.noteName;
    }
    cell.fromLabel.text = @"中国 深圳";
    cell.stateLabel.text = @"[在线]";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([buttonDic objectForKey:@(section)] == nil)
    {
        GroupButtonView *groupButton= [GroupButtonView buttonWithType:(UIButtonTypeCustom)];
        groupButton.frame = CGRectMake(0, 0, 320, 50);
        FriendGroupEntity *friendGroup = [titleArray objectAtIndex:section];
        groupButton.headLabel.text = friendGroup.groupName;
        groupButton.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat1@2x" ofType:@"png"]];
        [groupButton addTarget:self action:@selector(showGroup:) forControlEvents:(UIControlEventTouchUpInside)];
        [buttonDic setObject:groupButton forKey:@(section)];
        return groupButton;
    }
    else
    {
        return [buttonDic objectForKey:@(section)];
    }
 
}
-(void)showGroup:(id)sender
{
    GroupButtonView *button = (GroupButtonView *)sender;
    button.isOpen = !button.isOpen;
    [groupTable reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[allFriednDic allKeys] objectAtIndex:indexPath.section];
    NSMutableArray *array = [allFriednDic objectForKey:key];
    FriendEntity *_friend = [array objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chat" object:_friend];
}
@end
