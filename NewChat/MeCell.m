//
//  MeCell.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell
@synthesize headImg,messageLabel,nextImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 6.0f;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:20.0f];
        [self addSubview:messageLabel];
        
        UIImage *next = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"back" ofType:@"png" ]];
        nextImg = [[UIImageView alloc] initWithImage:next];
        [self addSubview:nextImg];
                             
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(12.75f, 21.75f, 25, 25)];
    [messageLabel setFrame:CGRectMake(80, 10, 150, 48.5f)];
    [nextImg setFrame:CGRectMake(300, 30, 7, 12)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
