//
//  InquiryViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InquiryViewController.h"
#import "InquiryCell.h"
#import "ChatWithPeopleViewController.h"
#import "InquiryEntity.h"
#import "InquiryStore.h"
@interface InquiryViewController ()

@end

@implementation InquiryViewController
@synthesize inquiryArray,userID;

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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //设置导航栏
    self.navigationItem.title = @"Inquiry";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }

    
    //设置表格
    inquiryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    inquiryTable.delegate = self;
    inquiryTable.dataSource = self;
    inquiryTable.separatorColor = [UIColor blackColor];
    inquiryTable.backgroundColor = [UIColor clearColor];
    if (iOS7)
    {
        [inquiryTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:inquiryTable];
    //准备数据
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    InquiryStore *store = (InquiryStore *)[app.store getStore:INQUIRY_ENT];
    [store selectInquiryByUserId:userID];
    inquiryArray = [store getEntArray];
    
    
    
    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [inquiryTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [inquiryArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    InquiryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[InquiryCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    InquiryEntity *inquiry = [inquiryArray objectAtIndex:indexPath.row];
    cell.headImg.image = [UIImage imageWithContentsOfFile:inquiry.filePath];
    cell.numLabel.text = [NSString stringWithFormat:@"%d",inquiry.orderId];
    cell.nameLabel.text = inquiry.userName;
    cell.messageLabel.text = inquiry.fileName;
    cell.styleImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat1" ofType:@"png"]];
//    cell.dateLabel.text = inquiry.;
    cell.fromLabel.text = inquiry.userPlace;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatWithPeopleViewController *chat = [[ChatWithPeopleViewController alloc] init];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    chat.userName = [userDefault objectForKey:@"username"];
    InquiryEntity *inquiry = [inquiryArray objectAtIndex:indexPath.row];
    chat.titleString = inquiry.orderCode;
    chat.flag = @"询价";
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}
@end
