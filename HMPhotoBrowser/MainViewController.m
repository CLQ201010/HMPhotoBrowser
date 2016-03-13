//
//  MainViewController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoUrls.h"
#import "PhotoCell.h"

NSString *const demoCellIdentifier = @"demoCellIdentifier";

@interface MainViewController () <UITableViewDataSource, PhotoCellDelegate>

@end

@implementation MainViewController {
    NSArray <PhotoUrls *> *_photoList;
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 准备表格
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.dataSource = self;
    [_tableView registerClass:[PhotoCell class] forCellReuseIdentifier:demoCellIdentifier];
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 2. 加载数据
    [self loadData];
}

- (void)loadData {
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 9; i++) {
        [arrayM addObject:[PhotoUrls photoUrlsWithCount:i + 1]];
    }
    _photoList = arrayM.copy;
}

#pragma mark - PhotoCellDelegate
- (void)photoCell:(PhotoCell *)cell didSelectedImageIndex:(NSInteger)index {
    NSLog(@"%zd", index);
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    if (indexPath == nil) {
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _photoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:demoCellIdentifier forIndexPath:indexPath];
    
    cell.photoUrls = _photoList[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

@end
