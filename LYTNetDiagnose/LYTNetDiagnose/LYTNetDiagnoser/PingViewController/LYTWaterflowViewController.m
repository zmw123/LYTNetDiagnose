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
#import "LYTHomeLabelButton.h"
#import "UIView+Extension.h"

@interface LYTWaterflowViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, YFWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic,retain) UIRefreshControl *refreshControl NS_AVAILABLE_IOS(6_0);
/** 存放标签 */
@property (nonatomic, strong) UIScrollView *labelsScrollView;
/** 存放具体的子控制器 */
@property (nonatomic, strong) UIScrollView *contentsScrollView;
@property (nonatomic, weak) LYTHomeLabelButton *selectedButton;

@end

@implementation LYTWaterflowViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

static NSString * const CellId = @"LYTPingLayoutCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网络测试";
    //
    [self setupChildVcs];
    //配置collctionView
    [self setUPCollectionView];
    //
    [self setScroolView];
    [self setupLabels];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self clickPingTest];
}
- (void)setUPCollectionView{
    // 创建布局
    LYTWaterflowLayout *layout = [[LYTWaterflowLayout alloc] init];
    layout.delegate = self;
    // 创建UICollectionView
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width,10 * 40);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"LYTPingLayoutCell" bundle:nil] forCellWithReuseIdentifier:CellId];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = YES;

}
- (void)setScroolView{
    NSLog(@"%f",self.collectionView.frame.size.height);
    _labelsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.collectionView.frame.size.height, self.view.bounds.size.width, 44)];
    _labelsScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_labelsScrollView];
    
    _contentsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelsScrollView.frame), self.view.bounds.size.width,self.view.bounds.size.height -CGRectGetMaxY(self.labelsScrollView.frame))];
    _contentsScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_contentsScrollView];
}
/**
 *  初始化子控制器
 */
- (void)setupChildVcs
{
    UIViewController *vc0 = [[UIViewController alloc] init];
    vc0.view.backgroundColor = [UIColor orangeColor];
    vc0.title = @"连通性";
    [self addChildViewController:vc0];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor purpleColor];
    vc1.title = @"TCP连接";
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"路由追踪";
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"体育";
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.title = @"国际";
    [self addChildViewController:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.title = @"哈哈";
    [self addChildViewController:vc5];
    
    UIViewController *vc6 = [[UIViewController alloc] init];
    vc6.title = @"呵呵";
    [self addChildViewController:vc6];
}
/**
 *  初始化顶部标签
 */
- (void)setupLabels
{
    // 不要刻意去调整scrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat labelButtonW = 90;
    NSUInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        // 取出i位置对应的子控制器
        UIViewController *childVc = self.childViewControllers[i];
        
        // 添加标签
        LYTHomeLabelButton *labelButton = [[LYTHomeLabelButton alloc] init];
        
        labelButton.height = self.labelsScrollView.height;
        NSLog(@"height = %f", self.labelsScrollView.height);
        labelButton.width = labelButtonW;
        labelButton.y = 0;
        labelButton.x = i * labelButtonW;
        
        [labelButton setTitle:childVc.title forState:UIControlStateNormal];
        [labelButton addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.labelsScrollView addSubview:labelButton];
    }
    
    // 设置内容大小
    self.labelsScrollView.contentSize = CGSizeMake(count * labelButtonW, 0);
    self.contentsScrollView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
    
    // 设置输入法
    self.contentsScrollView.delegate = self;
}
- (void)clickPingTest{
    [self.shops removeAllObjects];
    [self.collectionView reloadData];
    usleep(1000);
    [[LYTNetDiagnoser shareTool] testPingRequestHost:@"114.114.114.114" count:100 respose:^(LYTPingInfo *info) {
        LYTPingLayout *lyout = [[LYTPingLayout alloc] init];
        lyout.w = 40;
        lyout.h = 40;
        lyout.time = [NSString stringWithFormat:@"%.f", info.durationTime];
        
        [self.shops addObject:lyout];
        [self.collectionView reloadData];
    }];
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
#pragma mark - 私有方法
/**
 *  监听按钮点击
 */
- (void)labelClick:(LYTHomeLabelButton *)labelButton
{
    // 切换按钮状态
    self.selectedButton.selected = NO;
    labelButton.selected = YES;
    self.selectedButton = labelButton;
    
    // 切换子控制器
    NSUInteger index = [self.labelsScrollView.subviews indexOfObject:labelButton];
    [self switchChildVc:index];
}

/**
 *  切换子控制器
 *
 *  @param index 子控制器对应的索引
 */
- (void)switchChildVc:(NSUInteger)index
{
    // 添加index位置对应的控制器
    UIViewController *newChildVc = self.childViewControllers[index];
    if (newChildVc.view.superview == nil) {
        newChildVc.view.y = 0;
        newChildVc.view.width = self.contentsScrollView.width;
        newChildVc.view.height = self.contentsScrollView.height;
        newChildVc.view.x = index * newChildVc.view.width;
        [self.contentsScrollView addSubview:newChildVc.view];
    }
    
    // 滚动到index控制器对应的位置
    [self.contentsScrollView setContentOffset: CGPointMake(newChildVc.view.x, 0) animated:YES];
    
    // 让被点击的标签按钮显示在最中间
    CGFloat offsetX = self.selectedButton.centerX - self.labelsScrollView.width * 0.5;
    CGFloat maxOffsetX = self.labelsScrollView.contentSize.width - self.labelsScrollView.width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.labelsScrollView setContentOffset:offset animated:YES];
}




@end
