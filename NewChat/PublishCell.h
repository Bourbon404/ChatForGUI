//
//  PublishCell.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *fromLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIButton *likeImg;

@property (nonatomic,strong) NSMutableArray *imgArray;

@end
