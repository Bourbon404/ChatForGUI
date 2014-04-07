//
//  JobCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "JobCell.h"

@implementation JobCell
@synthesize headImg,bubbleImg,flagLabel,nameLabel,numLabel,styleLabel,addLabel,workLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code;
        self.backgroundColor = [UIColor clearColor];
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg = [[UIImageView alloc] initWithImage:img];
        [self addSubview:bubbleImg];
        
        flagLabel = [[UILabel alloc] init];
        [flagLabel setBackgroundColor:[UIColor clearColor]];
        flagLabel.text = @"new";
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.font = [UIFont systemFontOfSize:7.5f];
        [bubbleImg addSubview:flagLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:nameLabel];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [numLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:numLabel];
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(120, 30-3+5, 60, 20)];
        [work setTextColor:[UIColor whiteColor]];
        [work setText:@"职位招聘"];
        [work setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:work];
        
        workLabel = [[UILabel alloc] init];
        [workLabel setBackgroundColor:[UIColor clearColor]];
        [workLabel setTextColor:[UIColor whiteColor]];
        [workLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:workLabel];
        
        UILabel *sty = [[UILabel alloc] initWithFrame:CGRectMake(120,  45-3+5, 60, 20)];
        [sty setTextColor:[UIColor whiteColor]];
        [sty setText:@"职位类别"];
        [sty setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:sty];
        
        styleLabel = [[UILabel alloc] init];
        [styleLabel setBackgroundColor:[UIColor clearColor]];
        [styleLabel setTextColor:[UIColor whiteColor]];
        [styleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:styleLabel];
        
        UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 60, 20)];
        [num setTextColor:[UIColor whiteColor]];
        [num setText:@"招聘人数"];
        [num setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:num];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setTextColor:[UIColor whiteColor]];
        [numLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:numLabel];
        
        UILabel *add = [[UILabel alloc] initWithFrame:CGRectMake(120, 70-3-2,60, 20)];
        [add setTextColor:[UIColor whiteColor]];
        [add setText:@"工作地点:"];
        [add setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:add];
        
        addLabel = [[UILabel alloc] init];
        [addLabel setBackgroundColor:[UIColor clearColor]];
        [addLabel setTextColor:[UIColor whiteColor]];
        [addLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self addSubview:addLabel];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10+5, 80, 80)];
    [bubbleImg setFrame:CGRectMake(80, 0+5, 18, 18)];
    [flagLabel setFrame:CGRectMake(3, 3, 18, 10)];
    [nameLabel setFrame:CGRectMake(120, 10+5, 200, 10)];
    [workLabel setFrame:CGRectMake(180, 30-3+5, 150, 20)];
    [styleLabel setFrame:CGRectMake(180,  45-3+5, 150, 20)];
    [numLabel setFrame:CGRectMake(180, 80, 150, 20)];
    [addLabel setFrame:CGRectMake(180, 70-3-2, 150, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
