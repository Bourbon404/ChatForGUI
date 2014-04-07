//
//  ChatCell.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIImageView *bubbleImage;
@property (nonatomic,strong) UILabel *numLabel;

@end
