
//
//  TYHPortScanController.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/10.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "TYHPortScanController.h"

@interface TYHPortScanController ()
@property (weak, nonatomic) IBOutlet UITextField *domainTextField;
@property (weak, nonatomic) IBOutlet UITextField *conectTimes;
@property (weak, nonatomic) IBOutlet UITextField *conectPort;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)clickStart:(UIButton *)sender;
- (IBAction)clickAdd:(UIButton *)sender;

@end

@implementation TYHPortScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"端口检测";
    
}


- (IBAction)clickStart:(UIButton *)sender {
}

- (IBAction)clickAdd:(UIButton *)sender {
}
@end
