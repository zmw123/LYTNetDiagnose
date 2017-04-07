//
//  UIImage+GreyImage.m
//  TaiYangHua
//
//  Created by admin on 16/11/15.
//  Copyright © 2016年 hhly. All rights reserved.
//

#import "UIImage+GreyImage.h"

@implementation UIImage (GreyImage)

- (UIImage*) convertImageToGreyScale {
   
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, [self CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
}

@end
