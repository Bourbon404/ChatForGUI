//
//  OrderDetailCell.h
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UILabel *totalPriceLabel;

@end
