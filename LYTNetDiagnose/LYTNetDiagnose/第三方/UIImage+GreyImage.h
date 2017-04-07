//
//  UIImage+GreyImage.h
//  TaiYangHua
//
//  Created by admin on 16/11/15.
//  Copyright © 2016年 hhly. All rights reserved.
//
// creat by zhangsg 2016.11.15 离线状态头像置灰功能

#import <UIKit/UIKit.h>

@interface UIImage (GreyImage)

/**
 *  将彩色图片转化为灰色图片
 *
 @return 灰色图片
 */
- (UIImage *)convertImageToGreyScale;

@end
