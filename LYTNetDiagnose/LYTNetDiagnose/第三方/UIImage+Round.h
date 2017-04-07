//
//  UIImage+Round.h
//  BaiSiProject
//
//  Created by yangjie on 16/7/11.
//  Copyright © 2016年 HNB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Round)

+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor imageName:(NSString *)imageName;

- (UIImage *)roundImage;

- (UIImage *)roundImageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor;
/**
 *  根据图片名返回一张原始图片
 */
+ (instancetype)originImageWithName:(NSString *)imageName;


@end
