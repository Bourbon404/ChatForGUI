//
//  GameCell.h
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *bubbleImg;
@property (nonatomic,strong) UILabel *flagLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *nextImg;

@end
