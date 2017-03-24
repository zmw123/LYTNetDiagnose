//
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/23.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTPingLayoutCell.h"
#import "LYTPingLayout.h"
#import "LYTColorRank.h"

@interface LYTPingLayoutCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end


@implementation LYTPingLayoutCell
- (void)setShop:(LYTPingLayout *)shop
{
    _shop = shop;
    self.backgroundColor = [LYTColorRank pingColorWithDurationTime:shop.time];
    
    self.priceLabel.text = shop.time;
}

@end
