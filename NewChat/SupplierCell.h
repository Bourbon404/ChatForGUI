//
//  SupplierCell.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplierCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *headImage;
@property (nonatomic,strong) IBOutlet UIImageView *bubbleImg;
@property (nonatomic,strong) IBOutlet UILabel *flagLabel;
@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *fromLabel;
@property (nonatomic,strong) IBOutlet UILabel *productLabel;
@property (nonatomic,strong) IBOutlet UILabel *marketLabel;

@end
