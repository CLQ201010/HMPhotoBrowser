//
//  HMPhotoBrowserController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserController.h"
#import "HMPhotoBrowserPhotos.h"

@interface HMPhotoBrowserController ()

@end

@implementation HMPhotoBrowserController {
    HMPhotoBrowserPhotos *_photos;
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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", _photos);
}

@end
