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
#import "HMPhotoBrowserAnimator.h"

@interface HMPhotoBrowserController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation HMPhotoBrowserController {
    HMPhotoBrowserPhotos *_photos;
    BOOL _statusBarHidden;
    HMPhotoBrowserAnimator *_animator;
    
    UIImageView *_currentImageView;
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
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        _animator = [HMPhotoBrowserAnimator animatorWithPhotos:_photos];
        self.transitioningDelegate = _animator;
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
    _animator.fromImageView = _currentImageView;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(HMPhotoViewerController *)viewController {
    
    NSInteger index = viewController.photoIndex;
    
    if (index-- <= 0) {
        return nil;
    }
    
    return [self viewerWithIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(HMPhotoViewerController *)viewController {
    
    NSInteger index = viewController.photoIndex;
    
    if (++index >= _photos.urls.count) {
        return nil;
    }
    
    return [self viewerWithIndex:index];
}

- (HMPhotoViewerController *)viewerWithIndex:(NSInteger)index {
    return [HMPhotoViewerController viewerWithURLString:_photos.urls[index] photoIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    HMPhotoViewerController *viewer = pageViewController.viewControllers[0];
    
    _photos.selectedIndex = viewer.photoIndex;
    _currentImageView = viewer.imageView;
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    UIPageViewController *pageController = [[UIPageViewController alloc]
                                            initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                            navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                            options:@{UIPageViewControllerOptionInterPageSpacingKey: @20}];
    pageController.dataSource = self;
    pageController.delegate = self;
    
    HMPhotoViewerController *viewer = [self viewerWithIndex:_photos.selectedIndex];
    [pageController setViewControllers:@[viewer]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:YES
                            completion:nil];
    
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = pageController.gestureRecognizers;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tap];
    
    _currentImageView = viewer.imageView;
}

@end
