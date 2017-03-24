//
//  ViewController.m
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/23.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "ViewController.h"
#import "LYTNetDiagnoser.h"
@interface ViewController ()<LYTNetDiagnoseDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[LYTNetDiagnoser shareTool] startNetScanWithDelegate:self];
//    [[LYTNetDiagnoser shareTool] getDNSFromDomain:@"www.71chat.com" respose:^(LYTPingInfo *info) {
//        NSLog(@"%@",info);
//    }];
    [[LYTNetDiagnoser shareTool] testPingRequestDomain:@"www.baidu.com" count:1 respose:^(LYTPingInfo *info) {
        NSLog(@"%@",info);
    }];
}


/**
 开始扫描
 */
- (void)diagnoserBeginScan:(LYTNetDiagnoser *)dignoser{
    NSLog(@"开始扫描");
}

/**
 扫描完毕
 
 @param info 获取得到的网络信息
 */
- (void)diagnoserEndScan:(LYTNetDiagnoser *)dignoser netInfo:(LYTNetInfo *)info{
    NSLog(@"%@\n扫描结束\n",info);

}

@end
