//
//  AdverViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "AdverViewController.h"
#import "AdvertisementCell.h"
#import "SearchVIew.h"
@interface AdverViewController ()

@end

@implementation AdverViewController

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
    //搜索框界面
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    //navi上方的字
    self.navigationItem.title = @"Advertisement";
    if (iOS7)
    {
        NSDictionary *naivDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naivDic];
    }

    
    //数据列表
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor clearColor];
    listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (iOS7)
    {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    
    listTable.tableHeaderView = search;
    
    //设置beijing
    UIImage *backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    listTable.backgroundView = [[UIImageView alloc] initWithImage:backImage];
    [self.view addSubview:listTable];

    //初始化数据
    listArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView
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
    static NSString *CellIdentify = @"Cell";
    AdvertisementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[AdvertisementCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    cell.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"极品男装极品男装极品男装极品男装极品男装极品男装极品男装";
    cell.addrLabel.text = @"南美、欧洲、非洲";
    cell.priceLabel.text = @"￥40000.00";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end


