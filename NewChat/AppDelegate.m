//
//  AppDelegate.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import "ChatViewController.h"
#import "ContactViewController.h"
#import "BusinessViewController.h"
#import "ManagementViewController.h"
#import "MeViewController.h"
#import "ChatAdapter.h"
#import "UserAndMessageDatabase.h"
#import <CoreLocation/CoreLocation.h>
#import "IPAddress.h"

@implementation AppDelegate
@synthesize chat,contact,business,management,me;
@synthesize userName,passWord;

@synthesize store;
@synthesize database;
@synthesize sqliteDatabase;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    store = [[DataStore alloc] init];


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //判断是否与服务器相连
    [self testInternetConnection];
    
    
//    //网络相关
//    IPAddress *address  = [[IPAddress alloc] init];
//    NSString *localIP = [address getIPAddress:YES];
//    NSString *servIP = [address getIPWithHostName:@"www.mamarow.com"];
//
//    NSLog(@"本机地址:%@",localIP);
//    NSLog(@"远程地址:%@",servIP);
    
    //初始化中心
    chatB = [[ChatAdapter alloc] init];
    chatB.delegate = self;
    [ChatAdapter InitChatCore:@"192.168.1.68" mask:@"255.255.255.0"];
    [ChatAdapter BeginChatCore:@"192.168.1.68"];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatRecivNotify:) name:@MSGCENTERNAME object:nil];
    


    NSLog(@"%@",NSHomeDirectory());
    //判断时候存在userinfo.plist文件,如果不存在就创建.判断是否是空值，以此来判断是否自动登录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
    NSString *name = nil;
    NSString *password = nil;
    if ([fileManager fileExistsAtPath:filePath])
    {
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        name = [userDic objectForKey:@"username"];
        password = [userDic objectForKey:@"password"];
    }
    else
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"username",@"",@"password", nil];
        [userDic writeToFile:filePath atomically:YES];
    }

//    //判断密码是否为空值，如果是就是进入输入用户名和密码的界面，不是就自动登陆
//    if ([password isEqualToString:@""] || password == nil)
//    {
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        self.window.rootViewController = login;
//    }
//    else
//    {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
//        name = [dic objectForKey:@"username"];
//        password = [dic objectForKey:@"password"];
//
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:name forKey:@"username"];
//        [userDefault setObject:passWord forKey:@"password"];
//        [userDefault synchronize];
//
//        NSString *string = [NSString stringWithFormat:@"/user/%@",name];
//        [UserAndMessageDatabase createDatabaseIfNotExists:string];
//        
//        chat = [[ChatViewController alloc] init];
//        UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:chat];
//        UIImage *chatImg = [self imageWithFileName:@"chat1"];
//        navi1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"chat" image:chatImg tag:1001];
//        
//        contact = [[ContactViewController alloc] init];
//#warning 传入userID
//            contact.userID = 2001;
//            contact.userID = userID;
//        UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:contact];
//        UIImage *contactImg = [self imageWithFileName:@"contact1"];
//        navi2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"contact" image:contactImg tag:1002];
//        
//        business = [[BusinessViewController alloc] init];
//        business.userID = userID;
//        UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:business];
//        UIImage *businessImg = [self imageWithFileName:@"business1"];
//        navi3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"business" image:businessImg tag:1003];
//        
//        management = [[ManagementViewController alloc] initWithStyle:(UITableViewStylePlain)];
//        UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:management];
//        UIImage *mangementImg = [self imageWithFileName:@"mangement1"];
//        navi4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"mangement" image:mangementImg tag:1004];
//        
//        me = [[MeViewController alloc] init];
//        UINavigationController *navi5 = [[UINavigationController alloc] initWithRootViewController:me];
//        UIImage *meImg = [self imageWithFileName:@"me1"];
//        navi5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"me" image:meImg tag:1005];
//        
//        NSArray *tabArray = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,navi5, nil];
//        
//        UITabBarController *tabBar = [[UITabBarController alloc] init];
//        tabBar.viewControllers = tabArray;
//        
//        UIImage *backImg1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"标签栏@2x" ofType:@"png"]];
//        [tabBar.tabBar setBackgroundImage:backImg1];
//        
//        self.window.rootViewController = tabBar;
//    }
//
    
    application.applicationIconBadgeNumber = 0;
    
    //设置远程推送消息
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)DoEventAction:(NSMutableData *)buf bufsize:(int)nSize
{
    NSLog(@"fdsafdsafdsfsdafsdaf");
    typedef struct LoginRes
    {
        int act;
        int res;
        int userId;
    }LoginRes;
    
    LoginRes lgres;
    [buf getBytes:&lgres range:NSMakeRange(0, sizeof(LoginRes))];
    
    int act = lgres.act;
    int res = lgres.res;
    int userId = lgres.userId;
    
    NSLog(@"event act = %i, res = %i, userid = %i", act, res,  userId);
    
 }

-(void)DoEventData:(NSMutableData *)buf bufsize:(int)nSize
{
    typedef struct DataAct
    {
        int act;
        int type;
        int entId;
    }DataAct;
    
    DataAct act;
    [buf getBytes:&act range:NSMakeRange(0, sizeof(DataAct))];
    
    EntityType entType = (EntityType)act.type;
    
    BaseStore* basestore = [store getStore:entType];
    if (basestore == nil)  return;
    
    BaseEntity* ent = [basestore findEntity:act.entId];
    
    int nPos = sizeof(DataAct);
    if (act.act == DATA_DELETE)
    {
        if (ent != nil)
        {
            [basestore deleteEntity:ent]; 
            [basestore deleeteObjective:ent error:nil];
        }
    }
    else if (act.act == DATA_NEWUPD)
    {
        BOOL bNew = (ent == nil);
        if (bNew)
        {
            ent = [basestore createEnt];
            [basestore addEntity:ent];
        }
        
        [ent DecodeEntData:buf pos:nPos];
    
        
        if (bNew)
        {
            [basestore addObjective:ent error:nil];
        }
        else
        {
            [basestore updateObjeective:ent error:nil];
        }
    }
    
    NSLog(@"fdsfsd");
}

-(void) chatRecivNotify:(NSNotification *)noty
{
    NSDictionary *dict = noty.userInfo;
    [chatB OnRecvChatNotify:dict];
}

//检测是否连接服务器
-(void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    internetReachableFoo.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"we have the interwebs");
        });
    };
    
    internetReachableFoo.unreachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误信息" message:@"连接服务器失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        });
    };
    [internetReachableFoo startNotifier];
}
-(UIImage *)imageWithFileName:(NSString *)name
{
    name = [NSString stringWithFormat:@"%@@2x",name];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    return image;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"现在进入了后台");
    //进入后台回调函数
    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
        NSLog(@"进入了后台");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //进入前台取消回调函数
    NSLog(@"现在从后台进入了前台");
    [[UIApplication sharedApplication] clearKeepAliveTimeout];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//接受远程推送消息
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"设备令牌: %@", deviceToken);
    
//    NSString *tokeStr = [NSString stringWithFormat:@"%@",deviceToken];
//    
//    if ([tokeStr length] == 0) {
//        
//        return;
//        
//    }
//    
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\<\>"];
//    
//    tokeStr = [tokeStr stringByTrimmingCharactersInSet:set];
//    
//    tokeStr = [tokeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    NSString *strURL = @"http://192.168.1.103/push_chat_service.php";
//    
//    NSURL *url = [NSURL URLWithString:strURL];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    
//    [request setPostValue:tokeStr forKey:@"token"];
//    
//    [request setPostValue:@"98Z3R5XU29.com.51work6.PushChat" forKey:@"appid" ];
//    
//    [request setDelegate:self];
//    
//    NSLog(@”发送给服务器”);
//    
//    [request startAsynchronous];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"failed to get token, error ;%@",error);
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //以警告框的方式来显示推送消息
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!= NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"经过推送发送过来的消息" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
}
//接受本地推送消息
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接受本地提醒" message:notification.alertBody delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
