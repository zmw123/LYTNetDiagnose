//
//  LYTNetDiagnose
//
//  Created by Vieene on 2017/3/23.
//  Copyright © 2017年 Vieene. All rights reserved.
//
#import "LYTWaterflowViewController.h"
#import "LYTPingLayout.h"
#import "LYTPingLayoutCell.h"
#import "LYTWaterflowLayout.h"
#import "LYTNetDiagnoser.h"

@interface LYTWaterflowViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, YFWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic,retain) UIRefreshControl *refreshControl NS_AVAILABLE_IOS(6_0);

@end

@implementation LYTWaterflowViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

static NSString * const CellId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LYTNetDiagnoser.h";
    
    // 创建布局
    LYTWaterflowLayout *layout = [[LYTWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"LYTPingLayoutCell" bundle:nil] forCellWithReuseIdentifier:CellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [[LYTNetDiagnoser shareTool] testPingRequestHost:@"www.qq.com" count:100 respose:^(LYTPingInfo *info) {
        LYTPingLayout *lyout = [[LYTPingLayout alloc] init];
        lyout.w = 40;
        lyout.h = 40;
        lyout.time = [NSString stringWithFormat:@"%.f", info.durationTime];
        
        [self.shops addObject:lyout];
        [self.collectionView reloadData];
    }];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = @[];
        [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
        [self.collectionView reloadData];
        [self.refreshControl endRefreshing];
        
        // stop refresh
        //        [self.collectionView headerEndRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = @[];
        [self.shops addObjectsFromArray:newShops];
        [self.collectionView reloadData];
        
        // stop refresh
        //        [self.collectionView footerEndRefreshing];
    });
}

#pragma mark - <YFWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(LYTWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    LYTPingLayout *shop = self.shops[indexPath.item];
    return shop.h * itemWidth / shop.w;
}


#pragma mark - <UICollectionViewDataSource>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYTPingLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




@end
