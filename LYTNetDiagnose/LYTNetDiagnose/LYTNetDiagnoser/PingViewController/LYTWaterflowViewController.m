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

@interface LYTWaterflowViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, YFWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@end

@implementation LYTWaterflowViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        self.shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

static NSString * const CellId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"流水布局展示";
    
    // 初始化数据
    [self.shops addObjectsFromArray:@[]];
    
    // 创建布局
    LYTWaterflowLayout *layout = [[LYTWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"YFShopCell" bundle:nil] forCellWithReuseIdentifier:CellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 添加刷新控件
    //    [self.collectionView addHeaderWithCallback:^{
    //        NSLog(@"进入下拉刷新状态");
    //    }];
    //    [self.collectionView addFooterWithCallback:^{
    //        NSLog(@"进入shang拉刷新状态");
    //    }];
//    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewShops)];
//    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *newShops = @[];
        [self.shops insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
        [self.collectionView reloadData];
        
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

//- (UIEdgeInsets)insetsInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return UIEdgeInsetsMake(30, 30, 30, 30);
//}

//- (int)maxColumnsInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 2;
//}

//- (CGFloat)rowMarginInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 30;
//}
//
//- (CGFloat)columnMarginInWaterflowLayout:(YFWaterflowLayout *)waterflowLayout
//{
//    return 50;
//}

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
