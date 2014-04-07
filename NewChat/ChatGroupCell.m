//
//  ChatGroupCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatGroupCell.h"

@implementation ChatGroupCell
@synthesize headImageView1,headImageView2,headImageView3,headImageView4,messageLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImageView1 = [[UIImageView alloc] init];
        headImageView2 = [[UIImageView alloc] init];
        headImageView3 = [[UIImageView alloc] init];
        headImageView4 = [[UIImageView alloc] init];
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:headImageView1];
        [self addSubview:headImageView2];
        [self addSubview:headImageView3];
        [self addSubview:headImageView4];
        [self addSubview:messageLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImageView1 setFrame:CGRectMake(5, 9.25f, 25, 25)];
    [headImageView2 setFrame:CGRectMake(25+5, 9.25f, 25, 25)];
    [headImageView3 setFrame:CGRectMake(5, 25+9.25f, 25, 25)];
    [headImageView4 setFrame:CGRectMake(25+5, 25+9.25f, 25, 25)];
    [messageLabel setFrame:CGRectMake(80, 24.25f, 200, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
