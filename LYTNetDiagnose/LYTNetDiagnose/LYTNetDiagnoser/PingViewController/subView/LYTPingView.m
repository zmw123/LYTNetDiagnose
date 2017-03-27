//
//  LYTPingView.m
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/27.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTPingView.h"

@implementation LYTPingView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUI];
    }
    return self;
}
- (instancetype) initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI{
    //拿出xib视图
    NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"LYTPingView1" owner:nil options:nil];
    UIView *appview=[apparray firstObject];
    appview.frame = self.bounds;
    [self addSubview:appview];
}
@end
