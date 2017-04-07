//
//  UIImage+Round.m
//  BaiSiProject
//
//  Created by yangjie on 16/7/11.
//  Copyright © 2016年 HNB. All rights reserved.
//

#import "UIImage+Round.h"

@implementation UIImage (Round)

+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor imageName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    //0.设置边框宽度
    
    //1.加载图片
    
    //3.开启一个位图上下文
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContext(size);
    //4.绘制一个大圆0
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    //5.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    //6.把路径设置成裁剪区域
    [clipPath addClip];
    
    //7.把图片绘制到上下文当中
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    //8.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //9.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)roundImage {
    CGSize size = self.size;
    
    UIGraphicsBeginImageContext(size);
    //4.绘制一个大圆0
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];

    [path fill];
    //5.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //6.把路径设置成裁剪区域
    [clipPath addClip];
    
    //7.把图片绘制到上下文当中
    [self drawAtPoint:CGPointZero];
    
    //8.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //9.关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;

    
}

- (UIImage *)roundImageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor {
    
    //3.开启一个位图上下文
    CGSize size = CGSizeMake(self.size.width + 2 * borderW, self.size.height + 2 * borderW);
    UIGraphicsBeginImageContext(self.size);
    //4.绘制一个大圆0
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    //5.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, self.size.width, self.size.height)];
    //6.把路径设置成裁剪区域
    [clipPath addClip];
    
    //7.把图片绘制到上下文当中
    [self drawAtPoint:CGPointMake(borderW, borderW)];
    //8.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //9.关闭上下文
    UIGraphicsEndImageContext();

    
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    drawRect.size.width *= [UIScreen mainScreen].scale - 1;
    drawRect.size.height *= [UIScreen mainScreen].scale - 1;
    // 9.生成CG图片
    CGImageRef CGImage = CGImageCreateWithImageInRect(newImage.CGImage, drawRect);
    // 10.转化为OC图片
    newImage = [UIImage imageWithCGImage:CGImage];
    
    
    return newImage;
}


+ (instancetype)originImageWithName:(NSString *)imageName {
    
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}

@end
