//
//  InputCell.m
//  mamachat
//
//  Created by bourbon on 14-1-3.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "InputCell.h"

@implementation InputCell
@synthesize activity,chatView,failImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        activity = [[UIActivityIndicatorView alloc] init];
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"发送失败" ofType:@"png"]];
        failImage = [[UIImageView alloc] initWithImage:image];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
