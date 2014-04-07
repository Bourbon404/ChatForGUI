//
//  OrderViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "OrderEnt.h"
#import "OrderStore.h"
@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize orderArray;
@synthesize userID;
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
    self.navigationController.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //初始化背景
    self.navigationItem.title = @"Order";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }


    
    //初始化表格
    OrderTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    [OrderTable setDelegate:self];
    [OrderTable setDataSource:self];
    [OrderTable setSeparatorColor:[UIColor blackColor]];
    if (iOS7)
    {
        [OrderTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [OrderTable setBackgroundColor:[UIColor clearColor]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [OrderTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [self.view addSubview:OrderTable];
    
    //初始化数据
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    OrderStore *store = (OrderStore *)[app.store getStore:ORDER_ENT];
    [store selectOrderByUserId:userID];
    orderArray = [store getEntArray];
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orderArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[OrderCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    
    OrderEnt *order = [orderArray objectAtIndex:indexPath.row];
    cell.headImg.image = [UIImage imageWithContentsOfFile:order.headFile];
    cell.nameLabel.text = order.userName;
    cell.IDLabel.text = [NSString stringWithFormat:@"%i",order.orderId];
    cell.dateLabel.text = order.orderTime;
    cell.fromLabel.text = order.userPlace;
    
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
    OrderDetailViewController *detail = [[OrderDetailViewController alloc] init];
    OrderEnt *order = [orderArray objectAtIndex:indexPath.row];
    detail.titleString = order.userName;
    detail.totalNum = @"3000";
    detail.totalPrice = @"$32131";
    detail.date = order.orderTime;
    detail.location = order.userPlace;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
