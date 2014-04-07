//
//  ContactListCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactListCell.h"

@implementation ContactListCell
@synthesize headImage,nameLabel,messageLabel,agreeButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImage = [[UIImageView alloc] init];
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        agreeButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        
        [self addSubview:headImage];
        [self addSubview:nameLabel];
        [self addSubview:messageLabel];
        [self addSubview:agreeButton];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImage setFrame:CGRectMake(5, 5, 40, 40)];
    [nameLabel setFrame:CGRectMake(55, 5, 100, 20)];
    [messageLabel setFrame:CGRectMake(55, 5, 100, 10)];
    [agreeButton setFrame:CGRectMake(200, 15, 40, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
