//
//  FYNetworkAgent.m
//  FYNetworking
//
//  Created by YuWuChao on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYNetworkAgent.h"
#import "FYRequestBuilder.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

@interface FYNetworkAgent ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation FYNetworkAgent

+ (instancetype)sharedAgent {
    static dispatch_once_t onceToken;
    static FYNetworkAgent *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

- (void)cancelAllRequests {
    NSLog(@"取消所有请求");
}

- (void)GET:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodGET URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
    
    
}

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodPOST URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)PUT:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodPUT URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)HEAD:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodHEAD URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)DELETE:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodDELETE URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)PATCH:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:FYRequestMethodPATCH URLString:URLString requestSerializerType:FYRequestSerializerTypeHTTP parameters:nil constructingBodyBlock:nil headers:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}
@end
