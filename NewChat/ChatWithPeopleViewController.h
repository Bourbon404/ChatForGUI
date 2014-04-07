//
//  ChatWithPeopleViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LCVoice.h"

#import <AVFoundation/AVFoundation.h>

@class InputView;
@class FaceView;
@class AddView;
@interface ChatWithPeopleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate>
{
    NSMutableDictionary *cellDic;
    EGORefreshTableHeaderView *_regreshHeaderView;
    BOOL _reloading;
    
    LCVoice *voice;
    NSString *filePath;

    AVAudioPlayer *player;
    
    
}

@property (nonatomic,strong) InputView *inputView;
@property (nonatomic,strong) FaceView *faceView;
@property (nonatomic,strong) AddView *addView;
@property (nonatomic,strong) UIImageView *barView;

//需要从上一个界面传入
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *flag;
@property (nonatomic,copy) NSString *titleString;
@property (nonatomic,assign) int userID;
@property (nonatomic,assign) int friendID;

-(void)reloadTableViewDataSource;
-(void)doneLoadINgTableVIewData;

@end
