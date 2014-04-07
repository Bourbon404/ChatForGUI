//
//  JobCell.h
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *headImg;
@property (nonatomic,strong) IBOutlet UIImageView *bubbleImg;
@property (nonatomic,strong) IBOutlet UILabel *flagLabel;
@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *numLabel;
@property (nonatomic,strong) IBOutlet UILabel *styleLabel;
@property (nonatomic,strong) IBOutlet UILabel *addLabel;
@property (nonatomic,strong) IBOutlet UILabel *workLabel;
@end
