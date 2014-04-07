//
//  InputView.h
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView<UITextViewDelegate>

@property (nonatomic,strong) UIButton *addMoreButton;
@property (nonatomic,strong) UIButton *faceMoreButton;
@property (nonatomic,strong) UIButton *keyboardButton;
@property (nonatomic,strong) UIButton *voiceButton;
@property (nonatomic,strong) UIButton *longPriceButton;
@property (nonatomic,strong) UITextView *messageView;
@property (nonatomic,strong) UIImageView *backView;

@end
