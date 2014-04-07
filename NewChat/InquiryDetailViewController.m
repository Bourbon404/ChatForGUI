//
//  InquiryDetailViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InquiryDetailViewController.h"
#import "OrderDetailCell.h"

@interface InquiryDetailViewController ()
{
    UITableView *listTable;
    NSMutableArray *listArray;
}
@end

@implementation InquiryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //详情信息
    UIView *detialView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    detialView.backgroundColor = [UIColor clearColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 20)];
    label1.text = @"下单时间:";
    label1.font = [UIFont systemFontOfSize:15.0f];
    label1.textColor = [UIColor whiteColor];
    [detialView addSubview:label1];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 100, 20)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont systemFontOfSize:15.0f];
    [detialView addSubview:dateLabel];
    
    UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40-5, 100, 20)];
    [fromLabel setTextColor:[UIColor whiteColor]];
    [fromLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [detialView addSubview:fromLabel];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70-5, 70, 20)];
    label2.text = @"商品总数:";
    label2.font = [UIFont systemFontOfSize:15.0f];
    label2.textColor = [UIColor whiteColor];
    [detialView addSubview:label2];
    
    UILabel *totaNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 70-5, 100, 20)];
    [totaNumLabel setTextColor:[UIColor yellowColor]];
    [totaNumLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [detialView addSubview:totaNumLabel];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 70-5, 50, 20)];
    label3.text = @"总价格:";
    label3.font = [UIFont systemFontOfSize:15.0f];
    label3.textColor = [UIColor whiteColor];
    [detialView addSubview:label3];
    
    UILabel *totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 70-5, 70, 20)];
    [totalPriceLabel setTextColor:[UIColor yellowColor]];
    [totalPriceLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [detialView addSubview:totalPriceLabel];

    dateLabel.text = @"2013/01/02";
    fromLabel.text = @"中国 深圳";
    totaNumLabel.text = @"30000";
    totalPriceLabel.text = @"$20000";
    
    //准备表格
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor clearColor];
    listTable.tableHeaderView = detialView;
    listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:listTable];
    
    //准备背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [listTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    
    //准备navi
    self.navigationItem.title = self.titleString;
    
    //准备数据
    listArray = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"2",@"2",@"2",@"2", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableview Delegate
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
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    cell.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"破ing国最新发噶范德萨范德萨撒";
    cell.priceLabel.text = @"￥13000";
    cell.numLabel.text = @"456465";
    cell.totalPriceLabel.text = @"￥456456";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
