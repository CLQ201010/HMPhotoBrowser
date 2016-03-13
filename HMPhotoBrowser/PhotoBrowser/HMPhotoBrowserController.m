//
//  HMPhotoBrowserController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserController.h"
#import "HMPhotoBrowserPhotos.h"
#import "HMPhotoViewerController.h"

@interface HMPhotoBrowserController ()

@end

@implementation HMPhotoBrowserController {
    HMPhotoBrowserPhotos *_photos;
    BOOL _statusBarHidden;
}

#pragma mark - 构造函数
+ (instancetype)photoBrowserWithSelectedIndex:(NSInteger)selectedIndex urls:(NSArray<NSString *> *)urls parentImageViews:(NSArray<UIImageView *> *)parentImageViews {
    return [[self alloc] initWithSelectedIndex:selectedIndex
                                          urls:urls
                              parentImageViews:parentImageViews];
}

- (instancetype)initWithSelectedIndex:(NSInteger)selectedIndex urls:(NSArray<NSString *> *)urls parentImageViews:(NSArray<UIImageView *> *)parentImageViews {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _photos = [[HMPhotoBrowserPhotos alloc] init];
        
        _photos.selectedIndex = selectedIndex;
        _photos.urls = urls;
        _photos.parentImageViews = parentImageViews;
        
        _statusBarHidden = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _statusBarHidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _statusBarHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

#pragma mark - 监听方法
- (void)tapGesture {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.view.backgroundColor = [UIColor orangeColor];

    HMPhotoViewerController *viewer = [HMPhotoViewerController
                                       viewerWithURLString:_photos.urls[_photos.selectedIndex]
                                       photoIndex:_photos.selectedIndex];
    
    [self.view addSubview:viewer.view];
    [self addChildViewController:viewer];
    [viewer didMoveToParentViewController:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tap];
}

@end
