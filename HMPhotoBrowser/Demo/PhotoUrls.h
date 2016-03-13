//
//  PhotoUrls.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 配图 URL 数组模型
@interface PhotoUrls : NSObject

/// 配图 URL 字符串数组
@property (nonatomic, readonly, nonnull) NSArray <NSString *> *pic_urls;

/// 根据数量返回配图 URL 数组模型
///
/// @param count URL 数量
///
/// @return 配图数组模型
+ (nonnull instancetype)photoUrlsWithCount:(NSInteger)count;

@end
