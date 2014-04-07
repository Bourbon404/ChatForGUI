//
//  ChatWithPeopleViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatWithPeopleViewController.h"
#import "InquiryDetailViewController.h"
#import "InputView.h"
#import "FaceView.h"
#import "BubbleView.h"
#import "AddView.h"
#import "MessageObjective.h"
#import <AudioToolbox/AudioToolbox.h>
#import "HistoryViewController.h"
#import "InputCell.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "MessageStore.h"


#define HEIGHT self.view.frame.size.height
#define deviceWhdth   [[UIScreen mainScreen] bounds ].size.width
#define deviceHeight   [[UIScreen mainScreen] bounds ].size.height

@interface ChatWithPeopleViewController ()
{
    UIBarButtonItem *historyButton;
    UIBarButtonItem *doneButton;
    UITableView *chatTable;
    NSMutableArray *chatArray;
    UILabel *titleLabel;
    
}
@end

@implementation ChatWithPeopleViewController
@synthesize flag,titleString,inputView,faceView,addView,userName;
@synthesize userID,friendID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"goback" ofType:@"png"]];
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setBackgroundColor:[UIColor clearColor]];
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
    
    //navi上方的字
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = titleString;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:titleLabel];
    //如果上个界面是询价的话就进入这个东西
    if ([flag isEqualToString:@"询价"])
    {
        titleLabel.text = @"check order";
        titleLabel.userInteractionEnabled = YES;
        titleLabel.textColor = [UIColor yellowColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitle:)];
        [titleLabel addGestureRecognizer:gesture];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //发起聊天请求
    [ChatAdapter RequestChat:userID];
    
    
    //navi上的button
    historyButton = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:(UIBarButtonItemStylePlain) target:self action:@selector(historyTableView:)];
    [historyButton setTintColor:[UIColor whiteColor]];
    historyButton.tag = 1001;
    [doneButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = historyButton;
    
    //准备界面
    chatTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, HEIGHT-49) style:(UITableViewStylePlain)];
    chatTable.delegate = self;
    chatTable.dataSource = self;
    chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatTable.backgroundColor = [UIColor clearColor];
    chatTable.userInteractionEnabled = YES;

    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [chatTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    [self.view addSubview:chatTable];

    //准备数据
    chatArray = [[NSMutableArray alloc] initWithCapacity:0];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    MessageStore *store = (MessageStore *)[app.store getStore:MESSAGE_ENT];

    //获取当前用户username
    NSString *file = [NSString stringWithFormat:@"%@/Documents/UserInfo.plist",NSHomeDirectory()];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:file];
    NSString *name = [userDic objectForKey:@"username"];
    
//    [store selectMessageByUserName:name withFriend:titleString];
    
    
//    for (MessageObjective *message in [store getEntArray])
//    {
//        UIView *chatView = [[[BubbleView alloc] init] bubbleView:message.messageContent from:message.messageFrom];
//        [chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:message.messageContent,@"text",message.messageFrom,@"speaker",chatView,@"view", nil]];
//    }
    cellDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])
    {
        //设置底部工具栏
        if (iOS7) {
            inputView = [[InputView alloc] initWithFrame:CGRectMake(0, HEIGHT-44, 320, 49)];
        } else {
            inputView = [[InputView alloc] initWithFrame:CGRectMake(0, HEIGHT, 320, 49)];
        }
    }
    else
    {
        //设置底部工具栏
        if (iOS7) {
            inputView = [[InputView alloc] initWithFrame:CGRectMake(0, HEIGHT-49-64, 320, 49)];
        } else {
            inputView = [[InputView alloc] initWithFrame:CGRectMake(0, HEIGHT-49, 320, 49)];
        }
    }

    [inputView.faceMoreButton addTarget:self action:@selector(clickFaceButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [inputView.keyboardButton addTarget:self action:@selector(messageViewBecome) forControlEvents:(UIControlEventTouchUpInside)];
    [inputView.voiceButton addTarget:self action:@selector(clickVoiceButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [inputView.addMoreButton addTarget:self action:@selector(clickAddView:) forControlEvents:(UIControlEventTouchUpInside)];
    
    voice = [[LCVoice alloc] init];
    [inputView.longPriceButton addTarget:self action:@selector(recordStart) forControlEvents:(UIControlEventTouchDown)];
    [inputView.longPriceButton addTarget:self action:@selector(recordEnd) forControlEvents:(UIControlEventTouchUpInside)];
    [inputView.longPriceButton addTarget:self action:@selector(recordCancel) forControlEvents:(UIControlEventTouchUpOutside)];

    [self.view addSubview:inputView];
    
    //初始化刷新界面
    if (_regreshHeaderView == nil)
    {
        _regreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - chatTable.bounds.size.height, self.view.frame.size.width, chatTable.bounds.size.height)];
        _regreshHeaderView.delegate = self;
        _regreshHeaderView.backgroundColor = [UIColor clearColor];
        [chatTable addSubview:_regreshHeaderView];
    }

    //自适应键盘高度与消息中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickPicTake:) name:@"TakePic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickPicSelected:) name:@"SelectedPic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPic:) name:@"PicSelected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectFaceFromView:) name:@"selectFace" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activityViewStop:) name:@"activity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVoice:) name:@"voice" object:nil];
    
}

-(void)playVoice:(NSNotification *)noty
{
    NSString *str = [noty object];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:str];
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [newPlayer prepareToPlay];
    [newPlayer setDelegate:self];
    [newPlayer play];
}
#pragma mark 录音相关

//录音相关
//插入声音
-(void)insertAuido:(NSString *)string
{
    //输入框的信息写入数据库
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    BaseStore *store = [app.store getStore:MESSAGE_ENT];
    BaseEntity *ent = [store createEnt];
    MessageObjective *message = (MessageObjective *)ent;
    message.messageType = @"voice";
    message.messageFrom = userName;
    message.messageTo = titleString;
    message.messageContent = string;
    message.messageDate = [[NSDate date] timeIntervalSince1970];
    [store addObjective:message error:nil];
    
    UIView *chatView = [[[BubbleView alloc] init] bubbleView:@" " from:userName];
    [chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@" ",@"voice",userName,@"speaker",chatView,@"view",string,@"voicePath", nil]];
    [chatTable reloadData];
}
-(void)recordStart
{
    NSDate *time = [NSDate date];
    filePath = [NSString stringWithFormat:@"%@/Documents/%f.caf",NSHomeDirectory(),[time timeIntervalSince1970]];
    [voice startRecordWithPath:filePath];
}
-(void)recordEnd
{
    [voice stopRecordWithCompletionBlock:^{
        if (voice.recordTime >= 0.5f)
        {
            //插入声音
            [self insertAuido:voice.recordPath];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"voice" object:voice.recordPath];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告细腻" message:@"录音时间必须大于1秒" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }];
}
-(void)recordCancel
{
    [voice cancelled];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"取消了" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark 菊花相关
//停止菊花
-(void)activityViewStop:(NSNotification *)notify
{
    NSIndexPath *index = [notify object];
    InputCell *cell = (InputCell *)[chatTable cellForRowAtIndexPath:index];
    [cell.activity stopAnimating];
    [cell.activity removeFromSuperview];
    cell.failImage.hidden = NO;
}

#pragma mark Data Source Loading / Reloading Methods
-(void)reloadTableViewDataSource
{
    _reloading = YES;
}
-(void)doneLoadINgTableVIewData
{
    _reloading = NO;
    [_regreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:chatTable];
}
#pragma mark UIScrollViewDeleagate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_regreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_regreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark EGORefreshTableHeaderDelegate
//下拉一定距离,手指方开始调用
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    //停止加载，弹回下拉
    [self performSelector:@selector(doneLoadINgTableVIewData) withObject:nil afterDelay:2.0f];
    if (_barView == nil)
    {
        UIImage *img = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"timeline_new_status_background" ofType:@"png"]] stretchableImageWithLeftCapWidth:5 topCapHeight:5 ];
        _barView = [[UIImageView alloc] initWithImage:img];
        _barView.frame = CGRectMake(5, -40, 320-10, 40);
        [self.view addSubview:_barView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 100;
        label.font = [UIFont systemFontOfSize:16.0f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [_barView addSubview:label];
    }
    UILabel *label = (UILabel *)[_barView viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%d条信息更新",10];
    [label sizeToFit];
    CGRect frame = label.frame;
    frame.origin = CGPointMake((_barView.frame.size.width-frame.size.width)/2, (_barView.frame.size.height-frame.size.height)/2);
    label.frame = frame;
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:2.0f];
}
-(void)updateUI
{
    [UIView animateWithDuration:0.6f animations:^{
        CGRect frame = _barView.frame;
        frame.origin.y = 5;
        _barView.frame = frame;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelay:1.0f];
            [UIView setAnimationDuration:0.6f];
            CGRect frame = _barView.frame;
            frame.origin.y = -40;
            _barView.frame = frame;
            [UIView commitAnimations];
        }
    }];
    for (int i = 0; i < 10; i++)
    {
        MessageObjective *message = [[MessageObjective alloc] init];
        message.messageContent = @"fdsa";
        UIView *chatView = [[[BubbleView alloc] init] bubbleView:message.messageContent from:message.messageFrom];
        [chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:message.messageContent,@"text",message.messageFrom,@"speaker",chatView,@"view", nil]];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
    AudioServicesPlaySystemSound(soundId);
    [chatTable reloadData];
}
#pragma mark CLICK ADDVIEW
-(void)clickAddView:(id)sender
{
    inputView.longPriceButton.hidden = YES;
    inputView.keyboardButton.hidden = YES;
    inputView.messageView.hidden = NO;
    inputView.voiceButton.hidden = NO;
    [self.view endEditing:YES];
    if (addView == nil)
    {
        addView = [[AddView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-216, 320, 216)];
    }
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
    [self.view endEditing:YES];
    [inputView setFrame:CGRectMake(0, HEIGHT-216-49, 320, 49)];
    [self.view addSubview:addView];
}
//点击照相按钮
-(void)clickPicTake:(NSNotification *)notify
{
    UIImagePickerController *picker = [notify object];
    [self presentViewController:picker animated:YES completion:nil];
}
//点击照片选择
-(void)clickPicSelected:(NSNotification *)notify
{
    UIImagePickerController *picker = [notify object];
    [self presentViewController:picker animated:YES completion:nil];
}
//选择之后的照片
-(void)selectedPic:(NSNotification *)notify
{
    UIImage *image = [notify object];


    UIView *chatView = [[[BubbleView alloc] init] bubbleVIew:image from:userName];
    [chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:chatView,@"view",userName,@"speaker", nil]];
    [chatTable reloadData];

    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSMutableData *data = [NSMutableData dataWithData:imageData];
    int imageLength = [imageData length];
#warning 发送文件
    [ChatAdapter SendFile:0 filename:nil buf:data size:imageLength];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark Click Voice Button
//点击声音按钮
-(void)clickVoiceButton:(id)sender
{
    [inputView.messageView resignFirstResponder];
    inputView.frame = CGRectMake(0, HEIGHT-49, 320, 49);
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
}
//输入款成为焦点
-(void)messageViewBecome
{
    [inputView.messageView becomeFirstResponder];
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
}
#pragma mark CLICK FACE BUTTON
//单击表情按钮
-(void)clickFaceButton:(id)sender
{
    inputView.longPriceButton.hidden = YES;
    inputView.keyboardButton.hidden = YES;
    inputView.messageView.hidden = NO;
    inputView.voiceButton.hidden = NO;
    [self.view endEditing:YES];
    [inputView setFrame:CGRectMake(0, HEIGHT-216-49, 320, 49)];
    
    if (faceView == nil)
    {
        //设置表情界面
        faceView = [[FaceView alloc] initWithFrame:CGRectMake(0, HEIGHT-216, 320, 216)];
        [faceView.faceSendBtn addTarget:self action:@selector(clickFaceViewButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:faceView];
    }
    if (addView != nil)
    {
        [addView removeFromSuperview];
        addView = nil;
    }
}
//单击表情视图上的发送
-(void)clickFaceViewButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:inputView.messageView.text];
}
//选择表情
-(void)selectFaceFromView:(NSNotification *)notify
{
    NSString *face_String = notify.object;
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
    
    if (!([inputView.messageView.text isEqualToString:@""] || inputView.messageView.text == nil))
    {
        string = [NSMutableString stringWithFormat:@"%@",inputView.messageView.text];
    }
    [string appendString:face_String];
    inputView.messageView.text = string;
}
#pragma mark 自适应键盘高度
//自适应键盘高度
- (void)keyboardWillShow:(NSNotification *)notification
{
//    chatTable.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-216-49);
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
    if (addView != nil)
    {
        [addView removeFromSuperview];
        addView = nil;
    }
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue * aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [self autoMovekeyBoard:keyboardRect.size.height];
    
    //NSLog(@"%f",keyboardRect.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view endEditing:YES];
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
    if (addView != nil)
    {
        [addView removeFromSuperview];
        addView = nil;
    }
    
    //获取到文本里面的信息
    NSString *string = [notification object];
    if (!([string isEqualToString:@""] || string == nil))
    {
#warning 对某一条信息进行标示
        //发送内容
        [ChatAdapter SendTextMsg:1 user:friendID msg:string];
        
        //输入框的信息写入数据库
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
        BaseStore *store = [app.store getStore:MESSAGE_ENT];
        BaseEntity *ent = [store createEnt];
        MessageObjective *message = (MessageObjective *)ent;
        message.messageType = @"text";
        message.messageFrom = userName;
        message.messageTo = titleString;
        message.messageContent = string;
        message.messageDate = [[NSDate date] timeIntervalSince1970];
        [store addObjective:message error:nil];
        
        
        UIView *chatView = [[[BubbleView alloc] init] bubbleView:string from:message.messageFrom];
        [chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:string,@"text",message.messageFrom,@"speaker",chatView,@"view", nil]];
        [chatTable reloadData];
        //滚动到底部
        [chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[chatArray count]-1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        
    }
    
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self autoMovekeyBoard:0];
    inputView.messageView.text = nil;
}

-(void) autoMovekeyBoard: (float) h
{
	inputView.frame = CGRectMake(0.0f, (float)(deviceHeight-h-108.0), 320.0f, 44.0f);
    chatTable.frame = CGRectMake(0.0f, 0.0f, 320.0f,(float)(deviceHeight-h-108.0));
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [titleLabel removeFromSuperview];
    titleLabel = nil;
}
#pragma mark 可点击的标题
-(void)clickTitle:(id)sender
{
    InquiryDetailViewController *detail = [[InquiryDetailViewController alloc] init];
    detail.titleString = titleString;
    [titleLabel removeFromSuperview];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)historyTableView:(id)sender
{
#warning 停止菊花
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"activity" object:index];
    
    HistoryViewController *history = [[HistoryViewController alloc] initWithStyle:(UITableViewStylePlain)];
    history.userName = @"qwe";
    history.friendName = @"hued2";
    history.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:history animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chatArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[InputCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    NSDictionary *chatInfo = [chatArray objectAtIndex:indexPath.row];
    UIView *chatView = [chatInfo objectForKey:@"view"];

    NSString *user = [chatInfo objectForKey:@"speaker"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([user isEqualToString:[userDefault objectForKey:@"username"]])
    {
        //转动的菊花
        [cell.activity startAnimating];
        [cell.activity setFrame:CGRectMake(-15, 20, 6, 6)];
        [chatView addSubview:cell.activity];
        [cell.failImage setFrame:CGRectMake(-25, 15, 25, 25)];
        [chatView addSubview:cell.failImage];
        cell.failImage.hidden = YES;
    }
    [cell.contentView addSubview:chatView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *chatView = [[chatArray objectAtIndex:indexPath.row] objectForKey:@"view"];
    return chatView.frame.size.height+15;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [chatArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        [chatTable reloadData];
    }
}
#pragma mark 单击背景恢复原样
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [inputView setFrame:CGRectMake(0, HEIGHT-49, 320, 49)];
    if (faceView != nil)
    {
        [faceView removeFromSuperview];
        faceView = nil;
    }
    if (addView != nil)
    {
        [addView removeFromSuperview];
        addView = nil;
    }

    NSDictionary *dict = [chatArray objectAtIndex:indexPath.row];
    NSString *string = [dict objectForKey:@"voicePath"];

    NSLog(@"%@",string);
    
    if (string != nil)
    {
        NSString *path = string;
        NSURL *url = [NSURL fileURLWithPath:path];
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
    }

}
 

@end
