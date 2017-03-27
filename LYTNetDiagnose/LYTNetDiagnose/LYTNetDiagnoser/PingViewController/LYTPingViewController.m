//
//  LYTPingViewController.m
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/26.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTPingViewController.h"
#import "LYTPingView.h"
@interface LYTPingViewController ()

@end

@implementation LYTPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width,100);
    LYTPingView *pingView = [[LYTPingView alloc] initWithFrame:frame];
    [self.view addSubview:pingView];
    
}
@end
