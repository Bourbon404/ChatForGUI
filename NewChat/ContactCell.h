//
//  ContactCell.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *fromLabel;
@property (nonatomic,strong) UILabel *stateLabel;

@end
