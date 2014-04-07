//
//  JobViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "JobViewController.h"
#import "JobCell.h"
#import "SearchVIew.h"
@interface JobViewController ()

@end

@implementation JobViewController

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
    //初始化navi
    self.navigationItem.title = @"Job";
    
    //初始化搜索
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    //初始化数据
    listArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
    
    //初始化列表
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.tableHeaderView = search;
//    listTable.separatorColor = [UIColor blackColor];
    listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    listTable.backgroundColor = [UIColor clearColor];
    if (iOS7)
    {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:listTable];
    
    //设置beijing
    UIImage *backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [listTable setBackgroundView:[[UIImageView alloc] initWithImage:backImage]];
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[JobCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    cell.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"mamarow招聘";
    cell.numLabel.text = @"34";
    cell.styleLabel.text = @"货车司机";
    cell.addLabel.text = @"广东 深圳";
    cell.workLabel.text = @"全职";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
