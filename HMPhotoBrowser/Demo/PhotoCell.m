//
//  PhotoCell.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoUrls.h"
#import "YYWebImage/YYWebImage.h"
@import Masonry;

/// 图像 Cell 布局
typedef struct PhotoCellLayout {
    CGFloat viewWidth;
    CGFloat margin;
    
    CGSize itemSize;
    CGFloat itemMargin;
    NSInteger count;
} PhotoCellLayout;

@implementation PhotoCell {
    UIView *_pictureView;
    PhotoCellLayout _layout;
}

#pragma mark - 构造函数
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareUI];
    }
    return self;
}

#pragma mark - 公共方法
- (NSArray<UIImageView *> *)visibaleImageViews {
    NSMutableArray <UIImageView *>*arrayM = [NSMutableArray array];
    
    for (UIImageView *iv in _pictureView.subviews) {
        if (!iv.hidden) {
            [arrayM addObject:iv];
        }
    }
    
    return arrayM.copy;
}

#pragma mark - 设置数据
- (void)setPhotoUrls:(PhotoUrls *)photoUrls {
    _photoUrls = photoUrls;
    
    CGSize pictureViewSize = [self pictureViewSizeWithCount:photoUrls.pic_urls.count];
    [_pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(pictureViewSize.height);
    }];
    
    for (UIView *v in _pictureView.subviews) {
        v.hidden = YES;
    }
    
    NSInteger index = 0;
    for (NSString *urlString in photoUrls.pic_urls) {
        UIImageView *iv = _pictureView.subviews[index++];
        
        NSURL *url = [NSURL URLWithString:urlString];
        [iv yy_setImageWithURL:url placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            
            // 单图等比例缩放
            if (index == 1 && photoUrls.pic_urls.count == 1 && image != nil) {
                CGFloat height = pictureViewSize.height;
                CGFloat width = image.size.width * height / image.size.height;
                
                iv.frame = CGRectMake(0, 0, width, height);
            } else if (index == 1) {
                iv.frame = CGRectMake(0, 0, _layout.itemSize.width, _layout.itemSize.height);
            }
        }];
        
        iv.hidden = NO;
        
        if (index == 2 && photoUrls.pic_urls.count == 4) {
            index++;
        }
    }
}

- (CGSize)pictureViewSizeWithCount:(NSInteger)count {
    if (count == 0) {
        return CGSizeZero;
    }
    
    NSInteger row = (count - 1) / _layout.count + 1;
    CGFloat height = (row - 1) * _layout.itemMargin + row * _layout.itemSize.height;
    
    return CGSizeMake(_layout.itemSize.width, height);
}

#pragma mark - 监听方法
- (void)tapImageView:(UITapGestureRecognizer *)recognizer {
    NSInteger index = recognizer.view.tag;
    
    if (_photoUrls.pic_urls.count == 4 && index > 2) {
        index--;
    }
    
    if ([self.delegate respondsToSelector:@selector(photoCell:didSelectedImageIndex:)]) {
        [self.delegate photoCell:self didSelectedImageIndex:index];
    }
}

#pragma mark - 设置界面
- (void)prepareUI {
    // 0. 背景颜色
    self.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0];
    
    // 1. 准备布局
    [self prepareLayout];
    
    // 2. 添加控件
    _pictureView = [[UIView alloc] init];
    [self.contentView addSubview:_pictureView];
    
    // 3. 自动布局
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_layout.margin);
        make.leading.mas_equalTo(_layout.margin);
        
        make.width.mas_equalTo(_layout.viewWidth);
        make.height.mas_equalTo(_layout.viewWidth);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        
        make.bottom.equalTo(_pictureView).offset(_layout.margin);
    }];
    
    _pictureView.backgroundColor = [UIColor yellowColor];
    
    // 4. 准备图像视图
    [self prepareImageViews];
}

- (void)prepareImageViews {
    _pictureView.backgroundColor = self.backgroundColor;
    _pictureView.clipsToBounds = YES;
    
    NSInteger count = _layout.count * _layout.count;
    CGRect rect = CGRectMake(0, 0, _layout.itemSize.width, _layout.itemSize.height);
    CGFloat step = _layout.itemMargin + _layout.itemSize.width;
    
    for (NSInteger i = 0; i < count; i++) {
        
        // 1. 添加图像视图
        UIImageView *iv = [[UIImageView alloc] init];
        iv.backgroundColor = [UIColor lightGrayColor];
        iv.clipsToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        
        [_pictureView addSubview:iv];
        
        // 2. 设置图像视图位置
        NSInteger col = i % _layout.count;
        NSInteger row = i / _layout.count;
        
        iv.frame = CGRectOffset(rect, col * step, row * step);
        
        // 3. 添加手势
        iv.tag = i;
        iv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [iv addGestureRecognizer:tap];
    }
}

- (void)prepareLayout {
    _layout.margin = 12;
    _layout.itemMargin = 2;
    _layout.count = 3;
    
    _layout.viewWidth = [UIScreen mainScreen].bounds.size.width - (_layout.count - 1) * _layout.margin;
    CGFloat width = (_layout.viewWidth - (_layout.count - 1) * _layout.itemMargin) / _layout.count;
    _layout.itemSize = CGSizeMake(width, width);
}

@end
