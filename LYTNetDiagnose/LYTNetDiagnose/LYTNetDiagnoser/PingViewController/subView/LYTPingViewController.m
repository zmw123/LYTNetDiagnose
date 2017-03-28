//
//  LYTPingViewController.m
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/27.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTPingViewController.h"

@interface LYTPingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textDomain;
@property (weak, nonatomic) IBOutlet UITextField *pingCount;

- (IBAction)ClickPing:(UIButton *)sender;
@property (nonatomic,assign) BOOL ping;


@end

@implementation LYTPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


#pragma mark - private
- (NSString *)getDomain{
    return self.textDomain.text;
}

- (IBAction)ClickPing:(UIButton *)sender {
    if (_ping == YES) {
        
        if([self.delegate respondsToSelector:@selector(pingViewControllerStopPing)]){
            [self.delegate pingViewControllerStopPing];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(pingViewControllerStartPingAddress:count:)]) {
            [self.delegate pingViewControllerStartPingAddress:[self getDomain] count:[self.pingCount.text integerValue]];
        }
    }
    _ping = !_ping;
}
@end
