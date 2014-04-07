//
//  OrderDetailViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDeatEnt.h"
#import "OrderDetailCell.h"

@interface OrderDetailViewController ()
{
    UITableView *listTable;
    NSMutableArray *listArray;
    UIBarButtonItem *doSomeThing;
    UIBarButtonItem *doneButton;
}
@end

@implementation OrderDetailViewController
@synthesize titleString,totalNum,totalPrice,date,location;

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
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100-5, 50, 20)];
    [stateLabel setTextColor:[UIColor yellowColor]];
    [stateLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [detialView addSubview:stateLabel];
    dateLabel.text = date;
    fromLabel.text = location;
    totaNumLabel.text = totalNum;
    totalPriceLabel.text = totalPrice;
    stateLabel.text = @"已付款";
    
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
    doSomeThing = [[UIBarButtonItem alloc] initWithTitle:@"处理" style:(UIBarButtonItemStylePlain) target:self action:@selector(doSomeThingButton:)];
    doSomeThing.tintColor = [UIColor whiteColor];
    doSomeThing.tag = 1001;
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(doSomeThingButton:)];
    doneButton.tag = 1002;
    doneButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = doSomeThing;
    
    //准备数据
    OrderDeatEnt *orderDetail = [[OrderDeatEnt alloc] init];
    orderDetail.strProdFilePath = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"];
    orderDetail.strProductName = @"过范德萨范德萨发萨菲阿凡达";
    orderDetail.uProdSellPrice = 1300;
    orderDetail.uProdQty = 321;
    orderDetail.uProdSumPrice = 321312;
    listArray = [[NSMutableArray alloc] initWithObjects:orderDetail, nil];
}
-(void)doSomeThingButton:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    if (button.tag == 1001)
    {
        [listTable setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    else
    {
        [listTable setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem = doSomeThing;
    }
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
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[OrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    OrderDeatEnt *orderDetail = [listArray objectAtIndex:indexPath.row];
    cell.headImg.image = [UIImage imageWithContentsOfFile:orderDetail.strProdFilePath];
    cell.nameLabel.text = orderDetail.strProductName;
    cell.priceLabel.text = [NSString stringWithFormat:@"%i",orderDetail.uProdSellPrice];
    cell.numLabel.text = [NSString stringWithFormat:@"%i",orderDetail.uProdQty];
    cell.totalPriceLabel.text = [NSString stringWithFormat:@"%i",orderDetail.uProdSumPrice];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"确定要删除么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
@end

