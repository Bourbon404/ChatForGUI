//
//  ClientCell.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *sexImg;
@property (nonatomic,strong) UILabel *addLabel;
@property (nonatomic,copy) NSString *sexString;
@end
