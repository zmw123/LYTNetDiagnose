//
//  TYHbaseNavigationVC.m
//  TaiYangHua
//
//  Created by Vieene on 15/12/29.
//  Copyright © 2015年 hhly. All rights reserved.
//

#import "TYHbaseNavigationVC.h"
#import "UIImage+CH.h"
#import "UIImage+Round.h"
#import "UIImage+GreyImage.h"
#import "UIColor+TYHColor.h"
#import "LYTConfig.h"
//static NSString *TYHSessionListViewController  = @"TYHSessionListViewController";
//static NSString *TYHInternalCallViewController = @"TYHInternalCallViewController";


@interface TYHbaseNavigationVC ()<UINavigationBarDelegate>
/** 导航栏statusImageView */
@property(nonatomic,weak) UIImageView *statusImageView;
/** 导航栏iconimageView */
@property(nonatomic,weak) UIImageView *iconImageView;
@end

@implementation TYHbaseNavigationVC
//
+(void)initialize
{
    // 获取NavigationBar对象
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    // 设置背景
    UIImage *backgoundImage = [UIImage imageWithColor:color01a];
    [navigationBar setBackgroundImage:[backgoundImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置文字的颜色
    [navigationBar setTintColor:[UIColor getColor:@"ffffff"]];
    
    // 统一item的显示色
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTintColor:[UIColor whiteColor]];
  
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *attrs = @{NSFontAttributeName : font};
    navigationBar.titleTextAttributes = attrs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.translucent = NO;

}

//// 拦截push方法 设置导航栏信息
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    [super pushViewController:viewController animated:animated];
//
//    // 对指定的控制器设置左侧头像
//    if ([NSStringFromClass([viewController class]) isEqualToString:TYHSessionListViewController] ||
//        [NSStringFromClass([viewController class]) isEqualToString:TYHInternalCallViewController] ) {
//        
//         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self leftIconImageView]];
//    }
//    
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIBarButtonItem *)navRootVcLeftItem {
    return  [[UIBarButtonItem alloc] initWithCustomView:[self leftIconImageView]];
}

#pragma mark - 设置左侧头像 及事件监听 add by zhangsg 2016.11.22

- (UIImageView *)leftIconImageView {
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    self.iconImageView = imageV;
    
    UIImageView *statuImageV = [[UIImageView alloc] init];
    [imageV addSubview:statuImageV];
    self.statusImageView = statuImageV;
    
    [statuImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(imageV).offset(18);
        make.width.height.equalTo(@6);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftItem:)];
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:tap];
    return imageV;
}


@end
