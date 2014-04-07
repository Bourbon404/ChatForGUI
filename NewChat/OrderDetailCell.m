//
//  OrderDetailCell.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell
@synthesize headImg,nameLabel,priceLabel,numLabel,totalPriceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc] init];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        priceLabel.textColor = [UIColor yellowColor];
        priceLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:priceLabel];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        numLabel.textColor = [UIColor yellowColor];
        numLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:numLabel];
        
        totalPriceLabel = [[UILabel alloc] init];
        [totalPriceLabel setBackgroundColor:[UIColor clearColor]];
        totalPriceLabel.textColor = [UIColor yellowColor];
        totalPriceLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:totalPriceLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10+5, 80, 80)];
    [nameLabel setFrame:CGRectMake(120, 10+5, 200, 15)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 30-3+5, 200, 15)];
    label1.text = @"单价:";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:label1];
    [priceLabel setFrame:CGRectMake(180, 30-3+5, 150, 15)];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 45-3+5, 200, 15)];
    label2.text = @"购买数量:";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:label2];
    [numLabel setFrame:CGRectMake(180, 45-3+5, 150, 15)];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 70-3-2+5, 200, 15)];
    label3.text = @"总价格:";
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:label3];
    [totalPriceLabel setFrame:CGRectMake(180, 70-3-2+5, 150, 15)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
