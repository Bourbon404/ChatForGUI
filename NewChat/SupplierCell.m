//
//  SupplierCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SupplierCell.h"

@implementation SupplierCell
@synthesize headImage,bubbleImg,flagLabel,nameLabel,fromLabel,productLabel,marketLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImage = [[UIImageView alloc] init];
        [self addSubview:headImage];
        
        UIImage *bubble = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg = [[UIImageView alloc] init];
        bubbleImg.image = bubble;
        [self addSubview:bubbleImg];
        
        flagLabel = [[UILabel alloc] init];
        [flagLabel setBackgroundColor:[UIColor clearColor]];
        flagLabel.text = @"new";
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.font = [UIFont systemFontOfSize:7.5f];
        [bubbleImg addSubview:flagLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:nameLabel];
        
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [fromLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:fromLabel];
        
        UILabel *zhuying = [[UILabel alloc] initWithFrame:CGRectMake(120, 45-3+5,60, 20)];
        [zhuying setTextColor:[UIColor whiteColor]];
        [zhuying setText:@"主营产品"];
        [zhuying setBackgroundColor:[UIColor clearColor]];
        [zhuying setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:zhuying];
        
        productLabel = [[UILabel alloc] init];
        [productLabel setBackgroundColor:[UIColor clearColor]];
        [productLabel setTextColor:[UIColor yellowColor]];
        [productLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:productLabel];
        
        UILabel *place = [[UILabel alloc] initWithFrame:CGRectMake(120, 70-3-2+5, 60, 20)];
        [place setText:@"主营市场"];
        [place setTextColor:[UIColor whiteColor]];
        [place setBackgroundColor:[UIColor clearColor]];
        [place setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:place];
        
        marketLabel = [[UILabel alloc] init];
        [marketLabel setBackgroundColor:[UIColor clearColor]];
        [marketLabel setTextColor:[UIColor yellowColor]];
        [marketLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:marketLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImage setFrame:CGRectMake(10, 10+5, 80, 80)];
    [bubbleImg setFrame:CGRectMake(80, 0+5, 18, 18)];
    [flagLabel setFrame:CGRectMake(3, 3, 18, 10)];
    [nameLabel setFrame:CGRectMake(120, 10+5, 200, 10)];
    [fromLabel setFrame:CGRectMake(120, 30-3+5, 200, 10)];
    [productLabel setFrame:CGRectMake(160+10, 45-3+5, 200, 20)];
    [marketLabel setFrame:CGRectMake(160+10, 70-3-2+5, 200, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
