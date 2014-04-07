//
//  LoginViewController.h
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

#import "ChatAdapter.h"
#import "EventDelegate.h"

@class ChatViewController;
@class ContactViewController;
@class BusinessViewController;
@class ManagementViewController;
@class MeViewController;

@interface LoginViewController : UIViewController<CLLocationManagerDelegate,AVAudioRecorderDelegate,EventDelegate>
{
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *passField;
    IBOutlet UIImageView *backImg;
    
    NSURL *recordedTmpFile;
    AVAudioRecorder *recoder;
    
    ChatAdapter *chatB;
}

@property (nonatomic,strong) ChatViewController *chat;
@property (nonatomic,strong) ContactViewController *contact;
@property (nonatomic,strong) BusinessViewController *business;
@property (nonatomic,strong) ManagementViewController *management;
@property (nonatomic,strong) MeViewController *me;

@property (nonatomic,assign) int userID;

-(IBAction)clickLogin:(id)sender;
-(IBAction)clickRegist:(id)sender;
-(IBAction)clickForget:(id)sender;
-(IBAction)clickInfo:(id)sender;


@end
