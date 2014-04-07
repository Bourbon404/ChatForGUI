//
//  UIImage+UIImageExt.m
//  mamachat
//
//  Created by bourbon on 14-2-11.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "UIImage+UIImageExt.h"

@implementation UIImage (UIImageExt)
-(UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize))
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
        }
        else
        {
            scaleFactor = heightFactor;
        }
        scaleWidth = width * scaleFactor;
        scaleHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaleHeight) * 0.5;
        }
        else if(widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaleWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect .origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
@end
