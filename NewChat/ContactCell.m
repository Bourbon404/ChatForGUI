//
//  ContactCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell
@synthesize headImage,nameLabel,fromLabel,stateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImage = [[UIImageView alloc] init];
        headImage.layer.cornerRadius = 10.0f;
        headImage.layer.masksToBounds = YES;
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.font = [UIFont systemFontOfSize:17.0f];
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        [fromLabel setTextColor:[UIColor whiteColor]];
        fromLabel.font = [UIFont systemFontOfSize:15.0f];
        stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textColor = [UIColor whiteColor];
        stateLabel.font = [UIFont systemFontOfSize:15.0f];
        
        [self addSubview:headImage];
        [self addSubview:nameLabel];
        [self addSubview:fromLabel];
        [self addSubview:stateLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImage setFrame:CGRectMake(6.75f, 6.75f, 55, 55)];
    [nameLabel setFrame:CGRectMake(15+55, 24.25f, 160, 20)];
    [stateLabel setFrame:CGRectMake(150, 24.25f, 50, 20)];
    [fromLabel setFrame:CGRectMake(220, 24.25f,160, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
