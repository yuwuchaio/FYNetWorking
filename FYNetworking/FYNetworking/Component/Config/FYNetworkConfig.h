//
//  FYNetworkConfig.h
//  FYNetworking
//
//  Created by FishYu on 2018/5/23.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 网络请求的全局配置。
 */
@interface FYNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedConfig;

/// 基本的baseURL
@property (nonatomic, strong) NSString *baseURL;
/// sessionConfiguration.默认nil
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

@end

NS_ASSUME_NONNULL_END
