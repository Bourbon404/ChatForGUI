
//  LoginViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatViewController.h"
#import "ContactViewController.h"
#import "BusinessViewController.h"
#import "ManagementViewController.h"
#import "MeViewController.h"
#import "UserAndMessageDatabase.h"
#import "ChatAdapter.h"
#import "IPAddress.h"

#import <AVFoundation/AVFoundation.h>

#import "UserStore.h"
#import "UserObject.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize chat,contact,business,management,me;
@synthesize userID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //单机背景
    backImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackGround:)];
    [backImg addGestureRecognizer:gesture];
    self.navigationController.navigationBarHidden = YES;
    
    
    NSString *file = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSString *name = [userDic objectForKey:@"username"];
    NSString *password = [userDic objectForKey:@"password"];
    nameField.text = name;
    passField.text = password;

    [passField addTarget:self action:@selector(slideFrameUp) forControlEvents:(UIControlEventEditingDidBegin)];
    [passField addTarget:self action:@selector(slideFrameDown) forControlEvents:(UIControlEventEditingDidEnd)];
    
    //初始化userid
    userID = 2001;
}
-(void)slideFrameUp
{
    [self slideFrame:YES];
}
-(void)slideFrameDown
{
    [self slideFrame:NO];
}
-(void)slideFrame:(BOOL)up
{
    const int movementDistance = 100;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations:@"anim" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)clickLogin:(id)sender
{
    if (nameField.text == nil || [nameField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误信息" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if (passField.text == nil || [passField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误信息" message:@"用户名不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else
    {
        //将用户名和密码写入plist文件
        NSString *file = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
        NSString *name = [userDic objectForKey:@"username"];
        NSString *password = [userDic objectForKey:@"password"];
        
        name = nameField.text;
        password = passField.text;
        
        [userDic setObject:name forKey:@"username"];
        [userDic setObject:password forKey:@"password"];
        [userDic writeToFile:file atomically:YES];
        
        
        //创建数据库
        NSString *string = [NSString stringWithFormat:@"/user/%@",nameField.text];
        [UserAndMessageDatabase createDatabaseIfNotExists:string];

        //将用户名和密码写入appdelegate
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:nameField.text forKey:@"username"];
        [userDefault setObject:passField.text forKey:@"password"];
        [userDefault synchronize];
        
//        //写入db
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
//        BaseStore *store = [app.store getStore:USER_ENT];
//        BaseEntity *ent = [store createEnt];
//        UserObject *aUser = (UserObject *)ent;
//        aUser.userName = @"zhwe";
//        NSLog(@"%@",aUser);
//        [store addObjective:aUser error:nil];
        

        
#warning 获取userID
        //登陆事件
//        [ChatAdapter Login:NO user:name pwd:password];
        
        //获取全部好友
//        [ChatAdapter GetAllFriends];
//        [ChatAdapter SyncAllFriends];
        
        
        
        //活动指示框
//        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
//        [activity startAnimating];
//        [self.view addSubview:activity];
    
        
        
        
        
        
        //登陆成功
        [self showNextView];
    }
}

-(void) chatRecivNotify:(NSNotification *)noty
{
    NSDictionary *dict = noty.userInfo;
    [chatB OnRecvChatNotify:dict];
}
-(void)clickInfo:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"string" message:@"string" delegate:self cancelButtonTitle:@"string" otherButtonTitles:@"string", nil];
    [alert show];
}
-(void)clickForget:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"string" message:@"string" delegate:self cancelButtonTitle:@"string" otherButtonTitles:@"string", nil];
    [alert show];
}
-(void)clickRegist:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"string" message:@"string" delegate:self cancelButtonTitle:@"string" otherButtonTitles:@"string", nil];
    [alert show];
}
-(void)clickBackGround:(id)sender
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showNextView
{
    chat = [[ChatViewController alloc] init];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:chat];
    UIImage *chatImg = [self imageWithFileName:@"chat1"];
    chat.userId = userID;
    navi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"chat" image:chatImg tag:1001];
    
    
    contact = [[ContactViewController alloc] init];
#warning 传入userID
    contact.userID = userID;
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:contact];
    UIImage *contactImg = [self imageWithFileName:@"contact1"];
    navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"contact" image:contactImg tag:1002];
    
    business = [[BusinessViewController alloc] init];
    business.userID = userID;
    UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:business];
    UIImage *businessImg = [self imageWithFileName:@"business1"];
    navi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"business" image:businessImg tag:1003];
    
    management = [[ManagementViewController alloc] initWithStyle:(UITableViewStylePlain)];
    UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:management];
    UIImage *mangementImg = [self imageWithFileName:@"mangement1"];
    navi4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"mangement" image:mangementImg tag:1004];
    
    me = [[MeViewController alloc] init];
    UINavigationController *navi5 = [[UINavigationController alloc] initWithRootViewController:me];
    UIImage *meImg = [self imageWithFileName:@"me1"];
    navi5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"me" image:meImg tag:1005];
    
    NSArray *tabArray = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,navi5, nil];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = tabArray;
    
    UIImage *backImg1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"标签栏@2x" ofType:@"png"]];
    [tabBar.tabBar setBackgroundImage:backImg1];
    
    [self presentViewController:tabBar animated:YES completion:nil];
}
-(UIImage *)imageWithFileName:(NSString *)name
{
    name = [NSString stringWithFormat:@"%@@2x",name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    return image;
}


@end
