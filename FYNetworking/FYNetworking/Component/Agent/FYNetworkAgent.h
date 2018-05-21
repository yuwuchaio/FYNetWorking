//
//  FYNetworkAgent.h
//  FYNetworking
//
//  Created by YuWuChao on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FYResponse;

typedef void(^FYRequestCompletionHander)(FYResponse *response);
NS_ASSUME_NONNULL_BEGIN
@interface FYNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

// Get the shared agent.
+ (instancetype)sharedAgent;
//  Cancel all requests
- (void)cancelAllRequests;

// request methods
- (void)GET:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;

- (void)PUT:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;

- (void)HEAD:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;

- (void)DELETE:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;

- (void)PATCH:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion;
@end

NS_ASSUME_NONNULL_END
