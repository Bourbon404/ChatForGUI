//
//  BuyLeadCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "BuyLeadCell.h"

@implementation BuyLeadCell
@synthesize headImg,nameLabel,bubbleImg,addrLabel,priceLabel,nLabel,qiugouLabel,baojiaLabel,dateLabel,numLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg = [[UIImageView alloc] initWithImage:bubble];
        [self addSubview:bubbleImg];
        
        nLabel = [[UILabel alloc] init];
        nLabel.text = @"new";
        nLabel.textColor = [UIColor whiteColor];
        [nLabel setBackgroundColor:[UIColor clearColor]];
        nLabel.font = [UIFont systemFontOfSize:7.5f];
        [bubbleImg addSubview:nLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:nameLabel];
        
        addrLabel = [[UILabel alloc] init];
        [addrLabel setBackgroundColor:[UIColor clearColor]];
        addrLabel.textColor = [UIColor whiteColor];
        addrLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:addrLabel];
        
        priceLabel = [[UILabel alloc] init];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        priceLabel.textColor = [UIColor yellowColor];
        priceLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:priceLabel];
        
        qiugouLabel = [[UILabel alloc] init];
        [qiugouLabel setBackgroundColor:[UIColor clearColor]];
        qiugouLabel.textColor = [UIColor whiteColor];
        qiugouLabel.text = @"求购数量:";
        qiugouLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:qiugouLabel];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        numLabel.textColor = [UIColor yellowColor];
        numLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:numLabel];
        
        baojiaLabel = [[UILabel alloc] init];
        [baojiaLabel setBackgroundColor:[UIColor clearColor]];
        baojiaLabel.text = @"报价截止:";
        baojiaLabel.textColor = [UIColor whiteColor];
        baojiaLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:baojiaLabel];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textColor = [UIColor yellowColor];
        dateLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:dateLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [headImg setFrame:CGRectMake(10, 10+5, 80, 80)];
    [bubbleImg setFrame:CGRectMake(80, 0+5, 18, 18)];
    [nLabel setFrame:CGRectMake(3, 3, 18, 10)];
    [nameLabel setFrame:CGRectMake(120, 10+5, 200, 15)];
    [addrLabel setFrame:CGRectMake(120, 30-3+5, 200, 15)];

    [qiugouLabel setFrame:CGRectMake(120, 45-3+5, 200, 20)];
    [numLabel setFrame:CGRectMake(180, 45-3+5, 100, 20)];
    [baojiaLabel setFrame:CGRectMake(120, 70-3-2+5, 200, 20)];
    [priceLabel setFrame:CGRectMake(180, 70-3-2+5, 100, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
