//
//  HMPhotoBrowserAnimator.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

@import UIKit;
@class HMPhotoBrowserPhotos;

/// 照片浏览动画器
@interface HMPhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate>

/// 实例化动画器
///
/// @param photos 浏览照片模型
///
/// @return 照片浏览动画器
+ (nonnull instancetype)animatorWithPhotos:(HMPhotoBrowserPhotos * _Nonnull)photos;

@end
