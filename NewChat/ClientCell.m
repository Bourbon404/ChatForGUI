//
//  ClientCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ClientCell.h"

@implementation ClientCell
@synthesize headImg,nameLabel,sexImg,addLabel,sexString;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 10.0f;
        headImg.layer.masksToBounds = YES;
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor: [UIColor clearColor]];
        nameLabel.font = [UIFont systemFontOfSize:20.0f];
        nameLabel.textColor = [UIColor whiteColor];
        sexImg = [[UIImageView alloc] init];
        addLabel = [[UILabel alloc] init];
        [addLabel setBackgroundColor:[UIColor clearColor]];
        addLabel.font = [UIFont systemFontOfSize:12.0f];
        [addLabel setTextColor:[UIColor whiteColor]];
        
        [self addSubview:headImg];
        [self addSubview:nameLabel];
        [self addSubview:sexImg];
        [self addSubview:addLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(5, 5, 70, 70)];
    [nameLabel setFrame:CGRectMake(85, 30, 100, 20)];
    [addLabel setFrame:CGRectMake(220, 30, 100, 20)];
    
    UIImage *man = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"男人" ofType:@"png"]];
    UIImage *woman = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"女人" ofType:@"png"]];
    
    if ([sexString isEqualToString:@"man"])
    {
        sexImg.image = man;
        
    }
    else
    {
        sexImg.image = woman;
    }
    
    [sexImg setFrame:CGRectMake(150, 31.75f, 10, 16.5f)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
