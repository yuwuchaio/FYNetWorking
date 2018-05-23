//
//  FYNetworkConfig.m
//  FYNetworking
//
//  Created by FishYu on 2018/5/23.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYNetworkConfig.h"

@implementation FYNetworkConfig

+ (instancetype)sharedConfig {
    static id sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedConfig = [[self alloc] init];
    });
    return sharedConfig;
}

@end

