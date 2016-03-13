//
//  PhotoUrls.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "PhotoUrls.h"

@implementation PhotoUrls

+ (instancetype)photoUrlsWithCount:(NSInteger)count {
    return [[self alloc] initWithCount:count];
}

- (instancetype)initWithCount:(NSInteger)count {
    self = [super init];
    if (self) {
        NSAssert(count > 0 && count < 10, @"count 必须在 1~9 之间");
        
        NSArray <NSString *> *array = @[@"http://ww2.sinaimg.cn/bmiddle/72635b6agw1eyqehvujq1j218g0p0qai.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/e67669aagw1f1v6w3ya5vj20hk0qfq86.jpg",
                                        @"http://ww3.sinaimg.cn/bmiddle/61e36371gw1f1v6zegnezg207p06fqv6.gif",
                                        @"http://ww4.sinaimg.cn/bmiddle/7f02d774gw1f1dxhgmh3mj20cs1tdaiv.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/72635b6agw1eyqehod8k8j218g0p0tge.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/72635b6agw1eyqehp1eufj218g0p0n7q.jpg",
                                        @"http://ww1.sinaimg.cn/bmiddle/72635b6agw1eyqehqasdtj218g0p0137.jpg",
                                        @"http://ww3.sinaimg.cn/bmiddle/72635b6agw1eyqehrq346j218g0p0wtu.jpg",
                                        @"http://ww1.sinaimg.cn/bmiddle/72635b6agw1eyqehsq3fej218g0p0k58.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/72635b6agw1eyqehtr8xqj218g0p07au.jpg",
                                        @"http://ww2.sinaimg.cn/bmiddle/72635b6agw1eyqehui24lj218g0p0te5.jpg",
                                        @"http://ww3.sinaimg.cn/bmiddle/72635b6agw1eyqehvacmuj218g0p00wv.jpg"];
        
        _pic_urls = [array subarrayWithRange:NSMakeRange(0, count)];
    }
    return self;
}

- (NSString *)description {
    return _pic_urls.description;
}

@end
