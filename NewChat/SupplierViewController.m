//
//  SupplierViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SupplierViewController.h"
#import "SupplierCell.h"
#import "SearchVIew.h"
@interface SupplierViewController ()

@end

@implementation SupplierViewController

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
    self.navigationItem.title = @"Supplier";
    
    //设置搜索
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    //设置表格
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.backgroundColor = [UIColor clearColor];
    listTable.tableHeaderView = search;
//    listTable.separatorColor = [UIColor blackColor];
    listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([listTable respondsToSelector:@selector(setSeparatorInset:)])
    {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:listTable];
    
    //初始化数据
    supplierArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
    
    //设置beijing
    UIImage *backImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [listTable setBackgroundView:[[UIImageView alloc] initWithImage:backImage]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [supplierArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    SupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[SupplierCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"中国远东科技有限公司";
    cell.productLabel.text = @"电子、服饰、五金";
    cell.marketLabel.text = @"中国大陆";
    cell.fromLabel.text = @"中国 深圳";
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
