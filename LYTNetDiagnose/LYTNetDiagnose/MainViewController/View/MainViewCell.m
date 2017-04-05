//
//  MainViewCell.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/5.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "MainViewCell.h"
#import "MainViewModel.h"
#import "LYTConfig.h"
@implementation MainViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(MainViewModel *)model{
    _model = model;
    self.textLabel.text = model.title;
    self.textLabel.font = [UIFont systemFontOfSize:TitleFont];
    self.detailTextLabel.text = model.desTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:DestTitleFont];
    self.imageView.image = [UIImage imageNamed:model.imageName];
}
@end
