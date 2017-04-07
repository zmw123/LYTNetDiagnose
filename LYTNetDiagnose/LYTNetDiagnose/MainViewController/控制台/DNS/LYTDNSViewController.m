//
//  LYTDNSViewController.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/7.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTDNSViewController.h"
#import "LYTScreenView.h"
#import "LYTNetDiagnoser.h"
#import "LYTConfig.h"
#import "LYTSDKDataBase+LYTServersList.h"

@interface LYTDNSViewController ()
{
    NSMutableString *_log;
    LYTScreenView *_screeenView;

}
- (IBAction)clickAddbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *domainTextField;
@property (weak, nonatomic) IBOutlet UIButton *DNSBtn;
- (IBAction)DNSClick:(UIButton *)sender;

@end

@implementation LYTDNSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DNS";
    _log = [@"" mutableCopy];
    [self screeenView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self stopTraceroute];
}
- (LYTScreenView *)screeenView{
    if (!_screeenView) {
        _screeenView = [[LYTScreenView alloc] initWithContent:@""];
        [self.view addSubview:_screeenView];
    }
    return _screeenView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_screeenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.DNSBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.bottom.mas_equalTo(self.view).offset(-15);
    }];
}
- (IBAction)clickAddbtn:(UIButton *)sender {
    
}
- (IBAction)DNSClick:(UIButton *)sender {
    [[LYTNetDiagnoser shareTool] getDNSFromDomain:self.domainTextField.text respose:^(LYTPingInfo *info) {
        NSString *log = [NSString stringWithFormat:@"%@\n",info.infoStr];
        [self addLog:log];
    }];
}

- (void)addLog:(NSString *)log{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_log appendString:log];
        [_log appendString:@"\n"];
        _screeenView.content = _log;
        NSRange range = {_log.length,0};
        [_screeenView scrollToRange:range];
    });
}
@end
