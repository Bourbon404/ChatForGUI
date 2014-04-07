//
//  InterestProductCell.m
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InterestProductCell.h"

@implementation InterestProductCell
@synthesize headImg,nameLabel,fromLabel,priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:nameLabel];
        
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        [fromLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:fromLabel];
        
        priceLabel = [[UILabel alloc] init];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setTextColor:[UIColor yellowColor]];
        [priceLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:priceLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10, 100, 100)];
    [nameLabel setFrame:CGRectMake(120, 10, 200, 40)];
    [fromLabel setFrame:CGRectMake(120, 60, 200, 20)];
    [priceLabel setFrame:CGRectMake(120, 90, 200, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
