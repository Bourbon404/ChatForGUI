//
//  PublishViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishCell.h"
#import "PublishInfo.h"
#import "PublishStore.h"

@implementation PublishViewController

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
    //准备数据

    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    PublishInfo *publish = [[PublishInfo alloc] init];
    
    
    
    
    
    
    
     publishArray = [[NSMutableArray alloc] initWithObjects:publish, nil];
    
    
    
    
    
    
    
    
    
    
#warning 添加publish，准备数据
//    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
//    publish.headImg = image;
//    publish.name = @"雷昂那多";
//    publish.text = @"开心店铺，欢迎光临";
//    publish.from = @"中国 深圳";
//    publish.picArray = [NSMutableArray arrayWithObjects:image, nil];
//    publish.time = @"2013/10/10 pm 9:00";
//    publish.isLike = @"yes";
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //初始化背景
    self.navigationItem.title = @"Publish";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }

    
    //初始化四个按钮
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIImage *buttonImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"发布选择框@2x" ofType:@"png"]];
    UIImageView *buttonBackImg = [[UIImageView alloc] initWithImage:buttonImg];
    [buttonBackImg setBackgroundColor:[UIColor clearColor]];
    [buttonBackImg setFrame:CGRectMake(0, 0, 320, 44)];
    [buttonView addSubview:buttonBackImg];
    
    UIImage *selectImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"发布选择框选中@2x" ofType:@"png"]];
    allButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [allButton setTitle:@"all" forState:(UIControlStateNormal)];
    [allButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [allButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [allButton setFrame:CGRectMake(0, 0, 80, 44)];
    [allButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    allButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [allButton setBackgroundColor:[UIColor clearColor]];
    allButton.tag = 101;
    [allButton addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    productButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [productButton setTitle:@"new product" forState:(UIControlStateNormal)];
    [productButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [productButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [productButton setFrame:CGRectMake(0+80, 0, 80, 44)];
    [productButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    productButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    productButton.tag = 102;
    [productButton setBackgroundColor:[UIColor clearColor]];
    [productButton addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    shopButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shopButton setTitle:@"new shop" forState:(UIControlStateNormal)];
    [shopButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [shopButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [shopButton setFrame:CGRectMake(0+80+80, 0, 80, 44)];
    [shopButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    shopButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    shopButton.tag = 103;
    [shopButton setBackgroundColor:[UIColor clearColor]];
    [shopButton addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    adverButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [adverButton setTitle:@"advertisement" forState:(UIControlStateNormal)];
    [adverButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [adverButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [adverButton setFrame:CGRectMake(0+80+80+80, 0, 80, 44)];
    [adverButton setBackgroundImage:selectImg forState:(UIControlStateSelected)];
    adverButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [adverButton setBackgroundColor:[UIColor clearColor]];
    adverButton.tag = 104;
    [adverButton addTarget:self action:@selector(clickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [allButton setSelected:YES];
    
    [buttonView addSubview:allButton];
    [buttonView addSubview:productButton];
    [buttonView addSubview:shopButton];
    [buttonView addSubview:adverButton];
    
    //展示列表
    publishTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    publishTable.delegate = self;
    publishTable.dataSource = self;
    publishTable.separatorColor = [UIColor blackColor];
    if (iOS7)
    {
        [publishTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [publishTable setBackgroundColor:[UIColor clearColor]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [publishTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [publishTable setTableHeaderView:buttonView];
    [self.view addSubview:publishTable];
    

}
-(void)clickButton:(id)sender
{
    [allButton setSelected:NO];
    [productButton setSelected:NO];
    [shopButton setSelected:NO];
    [adverButton setSelected:NO];
    
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
}
#pragma mark UITabelView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [publishArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    PublishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[PublishCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }

    PublishInfo *publish = [publishArray objectAtIndex:indexPath.row];
#warning publish 数据
//    cell.headImg.image = publish.headImg;
//    cell.nameLabel.text = publish.name;
//    cell.messageLabel.text = publish.text;
//    cell.fromLabel.text = publish.from;
//    cell.dateLabel.text = publish.time;
//    cell.imgArray = publish.picArray;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int num = [[publishArray objectAtIndex:indexPath.row] integerValue];
    int num = indexPath.row;
    if (num <=2)
    {
        return 180+5+10;
    }
    else if (num >2 && num <=5)
    {
        return 265+5+10;
    }
    else
    {
        return 335+5+10;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
