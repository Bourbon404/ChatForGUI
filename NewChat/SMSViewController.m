//
//  SMSViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SMSViewController.h"
#import "SMSCell.h"
#import "ChatWithPeopleViewController.h"
#import "SMSInfo.h"
#import "SMSStore.h"
@interface SMSViewController ()

@end

@implementation SMSViewController
@synthesize smsArray;
@synthesize userID,friendID;

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
	// Do any additional setup after loading the view.
    //初始化背景
    self.navigationItem.title = @"SMS";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }


    
    //初始化表格
    smsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    [smsTable setDelegate:self];
    [smsTable setDataSource:self];
    [smsTable setSeparatorColor:[UIColor blackColor]];
    if (iOS7)
    {
        [smsTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [smsTable setBackgroundColor:[UIColor clearColor]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [smsTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [self.view addSubview:smsTable];
    
    //初始化数据
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
//    SMSStore *store = (SMSStore *)[app.store getStore:SMS_ENT];
//    [store selectSMSByUserID:userID];
//    smsArray = [store getEntArray];
   
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [smsArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    SMSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[SMSCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    
    SMSInfo *sms = [smsArray objectAtIndex:indexPath.row];
    
    cell.headImg.image = sms.headImg;
    cell.nameLabel.text = sms.name;
    cell.numLabel.text = [NSString stringWithFormat:@"%d",sms.bubbleNum];
    cell.styleImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat1" ofType:@"png"]];
    cell.dateLabel.text = sms.time;
    cell.fromLabel.text = sms.location;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatWithPeopleViewController *chat = [[ChatWithPeopleViewController alloc] init];
    SMSInfo *sms = [smsArray objectAtIndex:indexPath.row];
    chat.flag = @"SMS";
    chat.titleString = sms.name;
    chat.userID = userID;
    chat.friendID = friendID;
    chat.userName = sms.name;
    [self.navigationController pushViewController:chat animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
