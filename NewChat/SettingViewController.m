//
//  SettingViewController.m
//  mamachat
//
//  Created by bourbon on 14-1-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatAdapter.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

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
    //设置导航栏文字
    self.navigationItem.title = @"设置";
    
    //设置表格
    setTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:(UITableViewStylePlain)];
    setTable.delegate = self;
    setTable.dataSource = self;
    
    //退出按钮
    UIButton *LogOut = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [LogOut addTarget:self action:@selector(logoutButtonPress:) forControlEvents:(UIControlEventTouchUpInside)];
    [LogOut setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [LogOut setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [LogOut setTitle:@"退出登录" forState:(UIControlStateHighlighted)];
    [LogOut setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    UIImage *buttonImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"退出登陆" ofType:@"png"]];
    [LogOut setBackgroundImage:buttonImg forState:(UIControlStateNormal)];
    [LogOut setFrame:CGRectMake(25.75f, 20+10, 268.5f, 50)];
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80+10)];
    buttonView.backgroundColor = [UIColor clearColor];
    [buttonView addSubview:LogOut];
    [setTable setTableFooterView:buttonView];
    
    if (iOS7)
    {
        [setTable setSeparatorInset:(UIEdgeInsetsZero)];
    }
    setTable.separatorColor = [UIColor blackColor];
    
    //设置表格背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    setTable.backgroundView = [[UIImageView alloc] initWithImage:backImg];
    [self.view addSubview:setTable];
    
    //准备数据
    setArray = [NSMutableArray arrayWithObjects:@"新消息提醒",@"语言",@"显示字体大小",@"聊天背景",@"清空所有聊天记录",@"mamarow", nil];

}
-(void)logoutButtonPress:(id)sender
{
    NSString *file = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    [userDic setObject:@"" forKey:@"password"];
    [userDic writeToFile:file atomically:YES];
    
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    login.hidesBottomBarWhenPushed = YES;
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    //    transition.type = @"cube";          //立方体
    transition.type = @"suckEffect";    //吸收
    //    transition.type = @"rippleEffect";    //水纹
    //    transition.type = @"pageCurl";         //翻页
    //    transition.type = @"cameraIrisHollOpen";
    transition.subtype = kCATransitionFromRight;
    [self.navigationController pushViewController:login animated:YES];
    [self.navigationController.view.layer addAnimation:transition forKey:@"animation"];
    
    //中心登出
    [ChatAdapter Logout];
    [ChatAdapter ReleaseChatCore];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [setArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    
    cell.textLabel.text = [setArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
@end
