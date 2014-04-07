//
//  BusinessViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "BusinessViewController.h"
#import "SearchVIew.h"
#import "BusinessCell.h"

#import "PublishViewController.h"
#import "SMSViewController.h"
#import "VisitorViewController.h"
#import "OrderViewController.h"
#import "InquiryViewController.h"

@interface BusinessViewController ()

@end

@implementation BusinessViewController
@synthesize userID,friendID;

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
    // Do any additional setup after loading the view from its nib.
    //上方的白色字
    if (iOS7)
    {
        NSDictionary *barDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:barDic];
    }
    self.navigationItem.title = @"My Business";
    //搜索框界面
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    //背景颜色
    UIImage *naviImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"导航栏" ofType:@"png"]];
    //list列表
    if (iOS7)
    {
        listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-49) style:(UITableViewStylePlain)];
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    else
    {
        listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
        naviImg = [self scaleToSize:naviImg size:self.navigationController.navigationBar.bounds.size];
    }
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor clearColor];
    listTable.separatorColor = [UIColor blackColor];
    listTable.tableHeaderView = search;
    [self setExtraCellLineHidden:listTable];
    [self.view addSubview:listTable];
    [self.navigationController.navigationBar setBackgroundImage:naviImg forBarMetrics:(UIBarMetricsDefault)];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [listTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    //为下一个界面做准备
    menuArray = [[NSMutableArray alloc] initWithObjects:@"publish",@"sms",@"order",@"inquiry",@"visitor", nil];
}
//iOS 6  更改navi背景图片
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//去除多余分割线
-(void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[BusinessCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentify];
    }
    cell.headImg.image = [self menuImgWith:[menuArray objectAtIndex:indexPath.row]];
    cell.nextImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
    cell.messageLabel.text = [menuArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(UIImage *)menuImgWith:(NSString *)name
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    return image;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        PublishViewController *nextView = [[PublishViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        SMSViewController *nextView = [[SMSViewController alloc] init];
        nextView.userID = userID;
        nextView.friendID = friendID;
#warning 记得获取friendID;
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 2)
    {
        OrderViewController *nextView = [[OrderViewController alloc] init];
        nextView.userID = userID;
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 3)
    {
        InquiryViewController *nextView = [[InquiryViewController alloc] init];
        nextView.userID = userID;
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 4)
    {
        VisitorViewController *nextView = [[VisitorViewController alloc] init];
        nextView.userID = userID;
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
}
@end
