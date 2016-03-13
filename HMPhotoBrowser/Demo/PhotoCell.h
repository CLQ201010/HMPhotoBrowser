//
//  PhotoCell.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoUrls;

@protocol PhotoCellDelegate;

/// 图像 Cell
@interface PhotoCell : UITableViewCell

/// 代理
@property (nonatomic, weak, nullable) id<PhotoCellDelegate> delegate;
/// 配图 URL 数组模型
@property (nonatomic, nullable) PhotoUrls *photoUrls;

/// 当前可见的图像视图
- (NSArray <UIImageView *> * _Nonnull)visibaleImageViews;

@end

@protocol PhotoCellDelegate <NSObject>

/// 选中图像索引
///
/// @param cell  图像 Cell
/// @param index 图像索引
- (void)photoCell:(PhotoCell * _Nonnull)cell didSelectedImageIndex:(NSInteger)index;

@end


