//
//  MeViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "MeViewController.h"
#import "MeCell.h"
#import "MeView.h"
#import "InterestViewController.h"

#import "SettingViewController.h"

#import <AudioToolbox/AudioServices.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MeViewController ()
{
    NSMutableArray *menuArray;
}
@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Me";
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }

    //关于我
    MeView *meView = [[MeView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    meView.backgroundColor = [UIColor clearColor];

    
    //列表
    listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-49-64) style:(UITableViewStylePlain)];
    listTable.delegate = self;
    listTable.dataSource = self;
    listTable.separatorColor = [UIColor blackColor];
    if (iOS7)
    {
        [listTable setSeparatorInset:UIEdgeInsetsZero];
    }
    listTable.tableHeaderView = meView;
    listTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:listTable];
    
    //列表数据
    listArray = [[NSMutableArray alloc] initWithObjects:@"received options",@"interest",@"获取位置",@"设置",@"播放声音",nil];
    menuArray = [[NSMutableArray alloc] initWithObjects:@"receivedoptions",@"meinterest",@"receivedoptions",@"meinterest",@"meinterest",nil];
    //设置导航栏
    UIImage *naviImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"导航栏" ofType:@"png"]];
    if (!iOS7) {
        naviImg = [self scaleToSize:naviImg size:self.navigationController.navigationBar.bounds.size];
    }
    [self.navigationController.navigationBar setBackgroundImage:naviImg forBarMetrics:(UIBarMetricsDefault)];
    
    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [listTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [location stopUpdatingLocation];
}
//定位信息
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    float lat = currLocation.coordinate.latitude;   //正值代表北纬
    float lon = currLocation.coordinate.longitude; //正值代表东经
    
    if (lat != 0 && lon != 0)
    {
        NSString *string = [NSString stringWithFormat:@"您的当前位置为%f,%f",lat,lon];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"位置信息" message:string delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }
}
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
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
    return [listArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[MeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }

    cell.headImg.image = [self menuImgWith:[menuArray objectAtIndex:indexPath.row]];
    cell.messageLabel.text = [listArray objectAtIndex:indexPath.row];

    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(UIImage *)menuImgWith:(NSString *)name
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    return image;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSLog(@"开始设置一个本地通知");
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:5];
        //chuagjian一个本地推送
        UILocalNotification *noti = [[UILocalNotification alloc] init];
        if (noti) {
            //设置推送时间
            noti.fireDate = date;
            //设置时区
            noti.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复间隔
            noti.repeatInterval = NSWeekCalendarUnit;
            //推送声音
            noti.soundName = UILocalNotificationDefaultSoundName;
            //内容
            noti.alertBody = @"推送内容";
            //显示在icon上的红色圈中的数子
            noti.applicationIconBadgeNumber = 1;
            //设置userinfo 方便在之后需要撤销的时候使用
            NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
            noti.userInfo = infoDic;
            //添加推送到uiapplication
            UIApplication *app = [UIApplication sharedApplication];
            [app scheduleLocalNotification:noti];  
        }
        
    }
    else if (indexPath.row == 1)
    {
        InterestViewController *interest = [[InterestViewController alloc] init];
        interest.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:interest animated:YES];
    }
    else if (indexPath.row == 2)
    {
        //定位服务
        location = [[CLLocationManager alloc] init];
        location.delegate = self;
        location.desiredAccuracy = kCLLocationAccuracyBest;
        location.distanceFilter = 1000.0f;
        [location startUpdatingLocation];
    }
    else if (indexPath.row == 3)
    {
        SettingViewController *set = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:set animated:YES];
    }
    else if (indexPath.row == 4)
    {

    }

}
@end

