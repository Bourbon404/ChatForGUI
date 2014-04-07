//
//  PublishProdDetail.h
//  mamachat
//
//  Created by bourbon on 14-1-16.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import "BaseEntity.h"

@interface PublishProdDetail : BaseEntity

@property (nonatomic,assign) int publishId;
@property (nonatomic,assign) int productId;
@property (nonatomic,copy) NSString *prodFile;
@property (nonatomic,copy) NSString *prodFilePath;
@property (nonatomic,copy) NSString *publishProdTime;

@end
