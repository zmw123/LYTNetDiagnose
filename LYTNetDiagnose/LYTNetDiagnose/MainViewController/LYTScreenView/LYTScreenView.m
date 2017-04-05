//
//  LYTScreenView.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/5.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTScreenView.h"
#import "LYTConfig.h"
@interface LYTScreenView()
@property (copy,nonatomic) NSString *path;
@property (copy,nonatomic) NSString *content;
@property (nonatomic,strong) UITextView * textView;

@end

@implementation LYTScreenView
- (instancetype)initWithFilepath:(NSString *)path{
    if (self = [super init]) {
        _path = path;
        [self setUI];
    }
    return self;
}
- (instancetype)initWithContent:(NSString *)content{
    if (self = [super init]) {
        _content = content;
        [self setUI];
    }
    return self;
}
- (void)setUI{
    _textView = [[UITextView alloc] init];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.textColor = [UIColor greenColor];
    _textView.font = [UIFont systemFontOfSize:contentFont];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (void)scrollToRange:(NSRange)range{
    if (range.location<=[_textView.text length]){
        [_textView scrollRangeToVisible:range];
    }
}
@end
