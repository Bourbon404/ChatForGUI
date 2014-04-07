//
//  BubbleView.h
//  WorldTchChat
//
//  Created by Bourbon on 13-12-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BubbleView : UIView

-(UIView *)bubbleView: (NSString *) text from: (NSString *)aMessageFrom;
-(UIView *)bubbleVIew: (UIImage *) image from: (NSString *)aMessageFrom;


@end
