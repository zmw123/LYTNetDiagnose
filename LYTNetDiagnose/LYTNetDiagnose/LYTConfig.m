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
#define className @"className"
@implementation LYTConfig
+ (NSArray *)mainViewArray{
    NSArray *array = @[
                              @{title:@"ping",
                                desTitle:@"利用“ping”命令可以检查网络是否连通，可以很好地帮助我们分析和判定网络故障",
                                imageName:@"",
                                className:@"LYTPingViewController"},
                              @{title:@"Traceroute",
                                desTitle:@"用来发出数据包的主机到目标主机之间所经过的网关的工具",
                                imageName:@"",
                                className:@"TracerouteViewController2",
                                },
                              @{title:@"DNS",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"端口检测",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"局域网扫描",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"域名主机列表",
                                desTitle:@"",
                                imageName:@""},
                              @{title:@"历史记录",
                                desTitle:@"",
                                imageName:@""},
                    ];
    return array;
}
@end
