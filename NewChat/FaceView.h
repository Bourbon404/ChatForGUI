//
//  FaceView.h
//  mamachat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView<UIScrollViewDelegate>

// 表情相关
@property(nonatomic,retain)UIScrollView  *faceScrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)NSMutableArray *faceArry;
@property(nonatomic,retain)UIButton *faceSendBtn;
@property(nonatomic,retain)UIButton *button_face;

@end
