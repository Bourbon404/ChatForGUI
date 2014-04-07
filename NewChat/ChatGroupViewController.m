//
//  ChatGroupViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatGroupViewController.h"
#import "ChatGroupCell.h"
#import "ChatGroupCreatViewController.h"
#import "SearchVIew.h"
@interface ChatGroupViewController ()

@end

@implementation ChatGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"goback" ofType:@"png"]];
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setFrame:CGRectMake(0, 0, 11, 19)];
        [backButton setImage:image forState:(UIControlStateNormal)];
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:(UIControlEventTouchUpInside)];
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = back;
    }
    return self;
}
-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"聊天群";
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    if (iOS7)
    {
        chatGroupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44) style:(UITableViewStylePlain)];
    }
    else
    {
        chatGroupTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    }
    chatGroupTable.delegate = self;
    chatGroupTable.dataSource = self;
    chatGroupTable.backgroundColor = [UIColor clearColor];
    chatGroupTable.tableHeaderView = search;
    chatGroupTable.separatorColor = [UIColor blackColor];
    if (iOS7)
    {
        [chatGroupTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:chatGroupTable];
    
    UIImage *imgae = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [chatGroupTable setBackgroundView:[[UIImageView alloc] initWithImage:imgae]];
    
    groupArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
    //navi上的右边按钮
    UIImage *new1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"创建群" ofType:@"png"]];
    UIButton *newButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [newButton setImage:new1 forState:(UIControlStateNormal)];
    [newButton setFrame:CGRectMake(0, 0, 16, 16)];
    [newButton addTarget:self action:@selector(addNewGroup) forControlEvents:(UIControlEventTouchUpInside)];
    newGroup = [[UIBarButtonItem alloc] initWithCustomView:newButton];
    self.navigationItem.rightBarButtonItem = newGroup;
}
//添加群弹出框
-(void)addNewGroup
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新建聊天群" message:@"输入聊天群的名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.delegate = self;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *text = [alertView textFieldAtIndex:0].text;
    if (!(text == nil || [text isEqualToString:@""]))
    {
        [groupArray addObject:text];
        [chatGroupTable reloadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 创建新聊天群
-(void)clickButton:(id)sender
{
    ChatGroupCreatViewController *creat = [[ChatGroupCreatViewController alloc] init];
    [self.navigationController pushViewController:creat animated:YES];
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groupArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    ChatGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[ChatGroupCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.headImageView1.image = image;
    cell.headImageView2.image = image;
    cell.headImageView3.image = image;
    cell.headImageView4.image = image;
    cell.backgroundColor = [UIColor clearColor];
    cell.messageLabel.text = @"服装供应商的小伙伴么n";

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
@end
