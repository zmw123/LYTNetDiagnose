//
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/23.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTWaterflowLayout;

@protocol YFWaterflowLayoutDelegate <NSObject>
- (CGFloat)waterflowLayout:(LYTWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 *  返回四边的间距, 默认是UIEdgeInsetsMake(10, 10, 10, 10)
 */
- (UIEdgeInsets)insetsInWaterflowLayout:(LYTWaterflowLayout *)waterflowLayout;
/**
 *  返回最大的列数, 默认是3
 */
- (int)maxColumnsInWaterflowLayout:(LYTWaterflowLayout *)waterflowLayout;
/**
 *  返回每行的间距, 默认是10
 */
- (CGFloat)rowMarginInWaterflowLayout:(LYTWaterflowLayout *)waterflowLayout;
/**
 *  返回每列的间距, 默认是10
 */
- (CGFloat)columnMarginInWaterflowLayout:(LYTWaterflowLayout *)waterflowLayout;
@end



@interface LYTWaterflowLayout : UICollectionViewLayout
@property (nonatomic, weak) id<YFWaterflowLayoutDelegate> delegate;
@end
