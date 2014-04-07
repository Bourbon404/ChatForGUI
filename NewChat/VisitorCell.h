//
//  VisitorCell.h
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitorCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *bubbleImg;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *fromLabel;
@property (nonatomic,strong) UIImageView *sexImg;
@property (nonatomic,copy) NSString *sexString;

@end
