//
//  AdvertisementCell.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "AdvertisementCell.h"

@implementation AdvertisementCell
@synthesize headImg,nameLabel,bubbleImg,addrLabel,priceLabel,nLabel,mLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 10.0f;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg = [[UIImageView alloc] initWithImage:bubble];
        [self addSubview:bubbleImg];
        
        nLabel = [[UILabel alloc] init];
        [nLabel setBackgroundColor:[UIColor clearColor]];
        nLabel.text = @"new";
        nLabel.textColor = [UIColor whiteColor];
        nLabel.font = [UIFont systemFontOfSize:7.5f];
        [bubbleImg addSubview:nLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:nameLabel];

        mLabel = [[UILabel alloc] init];
        [mLabel setBackgroundColor:[UIColor clearColor]];
        mLabel.textColor = [UIColor whiteColor];
        [mLabel setFont:[UIFont systemFontOfSize:13.0f]];
        mLabel.text = @"投放地区:";
        [self addSubview:mLabel];
        
        addrLabel = [[UILabel alloc] init];
        [addrLabel setBackgroundColor:[UIColor clearColor]];
        addrLabel.textColor = [UIColor yellowColor];
        [addrLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:addrLabel];
        
        priceLabel = [[UILabel alloc] init];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        priceLabel.textColor = [UIColor yellowColor];
        priceLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:priceLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10+5, 80, 80)];
    [bubbleImg setFrame:CGRectMake(80, 0+5, 18, 18)];
    [nLabel setFrame:CGRectMake(3, 3, 18, 10)];
    [nameLabel setFrame:CGRectMake(120, 30, 200, 10)];
    [mLabel setFrame:CGRectMake(120, 45-3, 100, 30)];
    [addrLabel setFrame:CGRectMake(180, 45-3, 250, 30)];
    [priceLabel setFrame:CGRectMake(120, 70-3-2+5, 100, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
