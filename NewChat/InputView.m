//
//  InputView.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InputView.h"

@implementation InputView
@synthesize addMoreButton,faceMoreButton,keyboardButton,voiceButton,longPriceButton,messageView,backView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *messageBack = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"输入框背景" ofType:@"png"]];
        backView = [[UIImageView alloc] initWithImage:messageBack];
        [self addSubview:backView];
        
        addMoreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *addImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"添加" ofType:@"png"]];
        [addMoreButton setImage:addImg forState:(UIControlStateNormal)];
        [self addSubview:addMoreButton];
        
        faceMoreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *faceImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表情" ofType:@"png"]];
        [faceMoreButton setImage:faceImg forState:(UIControlStateNormal)];
        [self addSubview:faceMoreButton];
        
        keyboardButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *keyboardImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"键盘" ofType:@"png"]];
        [keyboardButton setImage:keyboardImg forState:(UIControlStateNormal)];
        [keyboardButton addTarget:self action:@selector(clickKeyboardButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:keyboardButton];
        
        voiceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *voiceImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"语音" ofType:@"png"]];
        [voiceButton setImage:voiceImg forState:(UIControlStateNormal)];
        [voiceButton addTarget:self action:@selector(clickVoiceButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:voiceButton];
        
        messageView = [[UITextView alloc] init];
        messageView.layer.cornerRadius = 5.0f;
        messageView.layer.masksToBounds = YES;
        messageView.returnKeyType = UIReturnKeySend;
        messageView.delegate = self;
        [self addSubview:messageView];
        
        longPriceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *normal = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"语言按钮" ofType:@"png"]];
        [longPriceButton setTitle:@"按住说话" forState:(UIControlStateNormal)];
        [longPriceButton setTitle:@"按住说话" forState:(UIControlStateSelected)];
        [longPriceButton setBackgroundImage:normal forState:(UIControlStateNormal)];


        
        [self addSubview:longPriceButton];
    }
    return self;
}
//键盘发送事件
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:textView.text];
        textView.text = @"";
        return NO;
    }
    else
    {
        return YES;
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [backView setFrame:CGRectMake(0, 0, 320, 49)];

    [addMoreButton setFrame:CGRectMake(5, 9, 31, 31)];
    [faceMoreButton setFrame:CGRectMake(5+31+5, 9, 31, 31)];
    [messageView setFrame:CGRectMake(5+31+5+31+5, 6, 195+5, 37)];
    [longPriceButton setFrame:CGRectMake(5+31+5+31+5, 6, 195+5, 37)];
    [keyboardButton setFrame:CGRectMake(5+31+5+31+5+195+5+5, 13, 32.5f, 23)];
    [voiceButton setFrame:CGRectMake(5+31+5+31+5+195+5+5+8.75f, 7.25f, 20.5f, 34.5f)];
    
    longPriceButton.hidden = YES;
    keyboardButton.hidden = YES;
    messageView.hidden = NO;
    voiceButton.hidden = NO;
}
-(void)clickVoiceButton:(id)sender
{
    longPriceButton.hidden = NO;
    keyboardButton.hidden = NO;
    voiceButton.hidden = YES;
    messageView.hidden = YES;
    
}
-(void)clickKeyboardButton:(id)sender
{
    longPriceButton.hidden = YES;
    keyboardButton.hidden = YES;
    messageView.hidden = NO;
    voiceButton.hidden = NO;
}

@end
