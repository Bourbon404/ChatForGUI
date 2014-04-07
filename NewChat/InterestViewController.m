//
//  InterestViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InterestViewController.h"
#import "InterestProductCell.h"
#import "InterestShopCell.h"
@interface InterestViewController ()

@end

@implementation InterestViewController
@synthesize productArray,shopArray;

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
    //准备navi
    self.navigationItem.title = @"Interest";
    
    //准备界面上的Button
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    buttonView.backgroundColor = [UIColor clearColor];
    UIImage *buttonBackImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"interest" ofType:@"png"]];
    UIImageView *buttonImg = [[UIImageView alloc] initWithImage:buttonBackImg];
    [buttonImg setFrame:CGRectMake(0, 0, 320, 44)];
    UIImage *selectImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"选择" ofType:@"png"]];
    productButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [productButton setTitle:@"product" forState:(UIControlStateNormal)];
    [productButton setTitle:@"product" forState:(UIControlStateHighlighted)];
    [productButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    [productButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [productButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [productButton setFrame:CGRectMake(0, 0, 160, 44)];
    [productButton addTarget:self action:@selector(buttonSelected:) forControlEvents:(UIControlEventTouchUpInside)];
    productButton.tag = 1001;
    [productButton setSelected:YES];
    [buttonView addSubview:productButton];

    shopButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shopButton setTitle:@"shop" forState:(UIControlStateNormal)];
    [shopButton setTitle:@"shop" forState:(UIControlStateHighlighted)];
    [shopButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    [shopButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [shopButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [shopButton setFrame:CGRectMake(160, 0, 160, 44)];
    shopButton.tag = 1002;
    [shopButton addTarget:self action:@selector(buttonSelected:) forControlEvents:(UIControlEventTouchUpInside)];
    [buttonView addSubview:shopButton];
    [self.view addSubview:buttonView];
    //展示列表
    productTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    productTable.delegate = self;
    productTable.dataSource = self;
    productTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    productTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:productTable];
    
    shopTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    shopTable.delegate = self;
    shopTable.dataSource = self;
    shopTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [shopTable setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:shopTable];
    
    [productTable setHidden:NO];
    [shopTable setHidden:YES];
    
    //准备数据
    productArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    shopArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    //navi右上角的button
    cleanButton = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:(UIBarButtonItemStylePlain) target:self action:@selector(cleanTable:)];
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(doneTable:)];
    self.navigationItem.rightBarButtonItem = cleanButton;
    
    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [productTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [shopTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
}
-(void)buttonSelected:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1001)
    {
        [productButton setSelected:YES];
        [shopButton setSelected:NO];
        [productTable setHidden:NO];
        [shopTable setHidden:YES];
        [productTable reloadData];
    }
    else
    {
        [productButton setSelected:NO];
        [shopButton setSelected:YES];
        [productTable setHidden:YES];
        [shopTable setHidden:NO];
        [shopTable reloadData];
    }
}
-(void)doneTable:(id)sender
{
    [productTable setEditing:NO animated:YES];
    [shopTable setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = cleanButton;
}
-(void)cleanTable:(id)sender
{
    if (productTable.hidden == NO)
    {
        [productTable setEditing:YES animated:YES];
    }
    else
    {
        [shopTable setEditing:YES animated:YES];
    }
    self.navigationItem.rightBarButtonItem = doneButton;
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == productTable)
    {
        return [productArray count];
    }
    else
    {
        return [shopArray count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    if (tableView == productTable)
    {
        InterestProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        if (cell == Nil)
        {
            cell = [[InterestProductCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
        }
        cell.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
        cell.nameLabel.text = @"范德萨范德萨范德萨范德萨";
        cell.fromLabel.text = @"中国 深圳";
        cell.priceLabel.text = @"￥4000.00";
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        InterestShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        if (cell == Nil)
        {
            cell = [[InterestShopCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
        }
        cell.headImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
        cell.nameLabel.text = @"范德萨范德萨范德萨范德萨";
        cell.fromLabel.text = @"中国 深圳";
        cell.mainLabel.text = @"主要商品：发生大幅度撒发生大幅范德萨发";
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"该信息已被删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
