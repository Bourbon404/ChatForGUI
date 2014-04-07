//
//  VistorDetailViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "VistorDetailViewController.h"

@interface VistorDetailViewController ()

@end

@implementation VistorDetailViewController

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
    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backImg];

    //设置可点击的个人详情
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
    UIImage *headImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    UIImageView *headView = [[UIImageView alloc] initWithImage:headImg];
    headView.layer.masksToBounds = YES;
    headView.layer.cornerRadius = 10.0f;
    [headView setFrame:CGRectMake(10, 10, 50, 50)];
    [infoView addSubview:headView];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 100, 20)];
    [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
    nameLabel.text = @"雷昂那多";
    [nameLabel setTextColor:[UIColor whiteColor]];
    [infoView addSubview:nameLabel];
    UIImage *sexImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat1@2x" ofType:@"png"]];
    UIImageView *sexView = [[UIImageView alloc] initWithImage:sexImg];
    [sexView setFrame:CGRectMake(150, 25, 20, 20)];
    [infoView addSubview:sexView];
    UIImage *nextImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"next" ofType:@"png"]];
    UIImageView *nextView = [[UIImageView alloc] initWithImage:nextImg];
    [nextView setFrame:CGRectMake(280, 25, 20, 20)];
    [infoView addSubview:nextView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickInfoView:)];
    infoView.userInteractionEnabled = YES;
    [infoView addGestureRecognizer:gesture];
    [self.view addSubview:infoView];
    
    //设置个人详情
    UILabel *addrLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
    addrLabel.text = @"中国 深圳";
    addrLabel.textColor = [UIColor whiteColor];
    addrLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:addrLabel];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 20)];
    timeLabel.text = @"拜访时间：2013/01/02";
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:timeLabel];
    UILabel *interestLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 100, 20)];
    interestLabel.text = @"感兴趣的产品:";
    interestLabel.textColor = [UIColor whiteColor];
    interestLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:interestLabel];

    //设置展示图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setFrame:CGRectMake(5*(j+1)+100*j,150+5*(i+1)+100*i , 100, 100)];
            [self.view addSubview:imageView];
        }
    }
}
-(void)clickInfoView:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"string" message:@"string" delegate:self cancelButtonTitle:@"string" otherButtonTitles:@"string", nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
