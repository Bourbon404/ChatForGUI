//
//  GroupButtonView.h
//  mamachat
//
//  Created by bourbon on 13-12-30.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupButtonView : UIButton

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,assign) BOOL isOpen;

@end
