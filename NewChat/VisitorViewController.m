//
//  VisitorViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "VisitorViewController.h"
#import "VisitorCell.h"
#import "VistorDetailViewController.h"
#import "VistorInfo.h"
#import "VistorStore.h"
@interface VisitorViewController ()

@end

@implementation VisitorViewController
@synthesize visitorArray;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //初始化背景
    self.navigationItem.title = @"Visitor";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }


    //初始化表格
    visitorTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    [visitorTable setDelegate:self];
    [visitorTable setDataSource:self];
    [visitorTable setSeparatorColor:[UIColor blackColor]];
    if ([visitorTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [visitorTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [visitorTable setBackgroundColor:[UIColor clearColor]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [visitorTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [self.view addSubview:visitorTable];
    
    //初始化数据
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    VistorStore *store = (VistorStore *)[app.store getStore:VISTOR_ENT];
    [store selectVistorByUserId:userID];
    visitorArray = [store getEntArray];
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [visitorArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    VisitorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[VisitorCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    
    VistorInfo *vistor = [visitorArray objectAtIndex:indexPath.row];
    
//    cell.headImg.image = vistor.headImg;
    cell.nameLabel.text = vistor.userName;
//    cell.sexString = vistor.sex;
    cell.dateLabel.text = vistor.browseTime;
    cell.fromLabel.text = vistor.userPlace;
    
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
    VistorDetailViewController *detail = [[VistorDetailViewController alloc] init];
    VistorInfo *vistor = [visitorArray objectAtIndex:indexPath.row];
    detail.navigationItem.title = vistor.userName;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
