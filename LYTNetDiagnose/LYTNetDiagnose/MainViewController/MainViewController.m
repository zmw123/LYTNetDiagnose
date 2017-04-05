//
//  MainViewController.m
//  LYTNetDiagnose
//
//  Created by 谭建中 on 2017/4/5.
//  Copyright © 2017年 Vieene. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewCell.h"
#import "MainViewModel.h"
#import "LYTConfig.h"
#import "MJExtension.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) UITableView * tabView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络监测";
    [self.view addSubview:self.tabView];
    [self setNav];
    
}

- (void)setNav{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (UITableView *)tabView{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc] init];
        _tabView.frame = self.view.bounds;
        _tabView.tableFooterView = [[UIView alloc] init];
        _tabView.dataSource = self;
        _tabView.delegate = self;
    }
    return _tabView;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [MainViewModel mj_objectArrayWithKeyValuesArray:[LYTConfig mainViewArray]];
    }
    return _dataSource;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ReuseId = @"MainViewCell";
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId];
    if (cell == nil) {
        cell = [[MainViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ReuseId];
    }
    id model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
#pragma mark - private
- (void)clickRightItem:(UIBarButtonItem *)item
{
    
}
@end
