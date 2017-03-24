//
//  LDNetPing.h
//  LDNetCheckServiceDemo
//
//  Created by 庞辉 on 14-10-29.
//  Copyright (c) 2014年 庞辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYTSimplePing.h"
#import "LYTPingInfo.h"

/*
 * @protocal LDNetPingDelegate监测Ping命令的的输出到日志变量；
 *
 */
@protocol LDNetPingDelegate <NSObject>
- (void)appendPingLog:(LYTPingInfo *)detecteInfo;
- (void)netPingDidEnd;
@end


/*
 * @class LDNetPing ping监控
 * 主要是通过模拟shell命令ping的过程，监控目标主机是否连通
 * 连续执行五次，因为每次的速度不一致，可以观察其平均速度来判断网络情况
 */
@protocol LDSimplePingDelegate;
@interface LYTNetPing : NSObject <LDSimplePingDelegate> {
}

@property (nonatomic, weak, readwrite) id<LDNetPingDelegate> delegate;

/**
 * 通过hostname 进行ping诊断
 */
- (void)runWithHostName:(NSString *)hostName normalPing:(BOOL)normalPing count:(NSInteger) count;

/**
 * 停止当前ping动作
 */
- (void)stopPing;

@end
