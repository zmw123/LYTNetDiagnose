//
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/23.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "LYTPingLayout.h"

@implementation LYTPingLayout
- (void)setTime:(NSString *)time{
    if ([time floatValue] == 0.f) {
        _time = @" ！";
    }else{
        _time = time;
    }
    
}
@end
