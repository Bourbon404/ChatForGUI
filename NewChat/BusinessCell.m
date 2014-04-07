//
//  BusinessCell.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell
@synthesize headImg,messageLabel,nextImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:20.0f];
        [self addSubview:messageLabel];
        
        nextImg = [[UIImageView alloc] init];
        [self addSubview:nextImg];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [headImg setFrame:CGRectMake(12.75f, 21.5f, 25, 25)];
    [messageLabel setFrame:CGRectMake(49, 24.25f, 180, 18.5)];
    [nextImg setFrame:CGRectMake(300, 30, 7, 12)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
