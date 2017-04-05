//
//  LYTConfig.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/5.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTConfig.h"

#define title @"title"
#define desTitle @"desTitle"
#define imageName @"imageName"
@implementation LYTConfig
+ (NSArray *)mainViewArray{
    NSArray *array = @[
                              @{title:@"ping检测",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"路由跟踪",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"DNS检测",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"端口检测",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"局域网扫描",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"测试地址列表",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"历史记录",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"设置",
                                desTitle:@"",
                                imageName:@""}
                              ];
    return array;
}
@end
