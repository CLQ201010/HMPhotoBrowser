//
//  HMPhotoViewerController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoViewerController.h"
@import YYWebImage;

@interface HMPhotoViewerController () <UIScrollViewDelegate>

@end

@implementation HMPhotoViewerController {
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    
    NSURL *_url;
    NSInteger _photoIndex;
}

#pragma mark - 构造函数
+ (instancetype)viewerWithURLString:(NSString *)urlString photoIndex:(NSInteger)photoIndex {
    return [[self alloc] initWithURLString:urlString photoIndex:photoIndex];
}

- (instancetype)initWithURLString:(NSString *)urlString photoIndex:(NSInteger)photoIndex {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _url = [NSURL URLWithString:urlString];
        _photoIndex = photoIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self loadImage];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

#pragma mark - 照片相关
- (void)loadImage {
    
    [_imageView yy_setImageWithURL: _url placeholder:nil options:0 completion:^
     (UIImage * _Nullable image,
      NSURL * _Nonnull url,
      YYWebImageFromType from,
      YYWebImageStage stage,
      NSError * _Nullable error) {
         
         if (image == nil) {
             return;
         }
         
         [self setImagePosition:image];
     }];
}

- (void)setImagePosition:(UIImage *)image {
    CGSize size = [self imageSizeWithScreen:image];
    
    _imageView.frame = CGRectMake(0, 0, size.width, size.height);
    _scrollView.contentSize = size;
    
    if (size.height < _scrollView.bounds.size.height) {
        CGFloat offsetY = (_scrollView.bounds.size.height - size.height) * 0.5;
        
        _scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, offsetY, 0);
    }
}

- (CGSize)imageSizeWithScreen:(UIImage *)image {
    CGSize size = [UIScreen mainScreen].bounds.size;
    size.height = image.size.height * size.width / image.size.width;
    
    return size;
}

#pragma mark - 设置界面
- (void)prepareUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_imageView];
    
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.delegate = self;
}

@end
