//
//  ProductCell.m
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
@synthesize headImg,bubbleImg,flagLabel,nameLabel,fromLabel,likeImg,priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg = [[UIImageView alloc] initWithImage:img];
        [self addSubview:bubbleImg];
        
        flagLabel = [[UILabel alloc] init];
        [flagLabel setText:@"new"];
        [flagLabel setBackgroundColor:[UIColor clearColor]];
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
        [fromLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:fromLabel];
    
        priceLabel = [[UILabel alloc] init];
        [priceLabel setBackgroundColor: [UIColor clearColor]];
        [priceLabel setTextColor:[UIColor cyanColor]];
        [priceLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:priceLabel];
        
        likeImg = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *norImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"默认喜欢" ofType:@"png"]];
        UIImage *selectImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"喜欢" ofType:@"png"]];
        [likeImg setImage:norImg forState:(UIControlStateNormal)];
        [likeImg setImage:selectImg forState:(UIControlStateSelected)];
        [likeImg addTarget:self action:@selector(clickButtonLike:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:likeImg];
    }
    return self;
}
-(void)clickButtonLike:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected == YES)
    {
        [button setSelected:NO];
    }
    else
    {
        [button setSelected:YES];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10+5, 80, 80)];
    [bubbleImg setFrame:CGRectMake(80, 0+5, 18, 18)];
    [flagLabel setFrame:CGRectMake(3, 3, 18, 10)];
    [nameLabel setFrame:CGRectMake(120, 10+5, 200, 15)];
    [fromLabel setFrame:CGRectMake(120, 30+5, 280, 30)];
    [likeImg setFrame:CGRectMake(120, 60+5, 22.5f,19)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
