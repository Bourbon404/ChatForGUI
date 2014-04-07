//
//  OrderCell.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell
@synthesize headImg,nameLabel,IDLabel,dateLabel,fromLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 10.0f;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self addSubview:nameLabel];
        
        IDLabel = [[UILabel alloc] init];
        [IDLabel setBackgroundColor:[UIColor clearColor]];
        [IDLabel setTextColor:[UIColor yellowColor]];
        [IDLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:IDLabel];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [dateLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:dateLabel];
        
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [fromLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [fromLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:fromLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [headImg setFrame:CGRectMake(6.75f, 6.75f, 55, 55)];
    [nameLabel setFrame:CGRectMake(10+40+10+10, 14.25f, 100, 15)];
    [IDLabel setFrame:CGRectMake(10+40+10+10, 14.25f+10+15, 150, 15)];
    [dateLabel setFrame:CGRectMake(190, 10.25f, 120, 20)];
    [fromLabel setFrame:CGRectMake(240, 35, 70, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
