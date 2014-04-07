//
//  InputCell.h
//  mamachat
//
//  Created by bourbon on 14-1-3.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCell : UITableViewCell

@property (nonatomic,strong) UIView *chatView;
@property (nonatomic,strong) UIActivityIndicatorView *activity;
@property (nonatomic,strong) UIImageView *failImage;

@end
