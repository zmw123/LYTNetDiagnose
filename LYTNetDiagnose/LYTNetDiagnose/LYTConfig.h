//
//  LYTConfig.h
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/5.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"
#define TitleFont 19
#define DestTitleFont 14
#define contentFont 13

#define LYWeakSelf __weak typeof(self) weakSelf = self;

@interface LYTConfig : NSObject
+ (NSArray *)mainViewArray;
@end
