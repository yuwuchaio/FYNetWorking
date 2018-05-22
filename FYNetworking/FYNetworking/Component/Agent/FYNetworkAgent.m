//
//  FYNetworkAgent.m
//  FYNetworking
//
//  Created by YuWuChao on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYNetworkAgent.h"
#import "FYRequestBuilder.h"
#import "FYResponse.h"

#import <pthread/pthread.h>
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif


#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

@interface FYNetworkAgent (){
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, FYRequestCompletionHander> *taskCompletionMapper;

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
        _taskCompletionMapper = [NSMutableDictionary dictionary];
        
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)cancelAllRequests {
    Lock();
    [self.taskCompletionMapper removeAllObjects];
    Unlock();
}

- (NSURLRequest *)requestWithHTTPMethod:(FYRequestMethod)method
                              URLString:(NSString *)URLString
                             parameters:(id)parameters
                                headers:(NSDictionary <NSString *, NSString *>*)headers
                  requestSerializerType:(FYRequestSerializerType)serializerType
                  constructingBodyBlock:(AFConstructingBlock)block
                                  error:(NSError *__autoreleasing  *)error {
    NSURLRequest *request = [[FYRequestBuilder shareBuilder] buildRequetWithHTTPMethod:method URLString:URLString requestSerializerType:serializerType parameters:parameters constructingBodyBlock:block headers:headers error:error];
    return  request;
}

- (void)GET:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
    
    NSError * __autoreleasing requestSerializationError = nil;
    
    NSURLRequest *request = [self requestWithHTTPMethod:FYRequestMethodGET URLString:URLString parameters:parameters headers:nil requestSerializerType:FYRequestSerializerTypeHTTP constructingBodyBlock:nil error:&requestSerializationError];
    // request serialize error
    if (requestSerializationError) {
        [self requestDidFailWithDataTask:nil error:requestSerializationError];
        return;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self handleTask:dataTask responseObject:responseObject error:error];
    }];
    Lock();
    self.taskCompletionMapper[@(dataTask.taskIdentifier)] = completion;
    Unlock();
    [dataTask resume];
    
    
}

- (void)POST:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
  
}

- (void)PUT:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
 
}

- (void)HEAD:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
 
}

- (void)DELETE:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
 
}

- (void)PATCH:(NSString *)URLString parameters:(id)parameters requestCompletionHander:(FYRequestCompletionHander)completion {
 
}

- (void)handleTask:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    
    if (error) {
        [self requestDidFailWithDataTask:task error:error];
    }else {
        [self requestDidSucceedWithDataTask:task responseObject:responseObject];
    }
    Lock();
    [self.taskCompletionMapper removeObjectForKey:@(task.taskIdentifier)];
    NSLog(@"Request count size = %zd", [self.taskCompletionMapper count]);
    Unlock();
}

// handle request result
- (void)requestDidFailWithDataTask:(NSURLSessionTask *)task error:(NSError *)error {
    FYResponse *response = [[FYResponse alloc] initWithResponseData:nil requestTask:task error:error];
    Lock();
    FYRequestCompletionHander completion =  [self.taskCompletionMapper objectForKey:@(task.taskIdentifier)];
    Unlock();
    if (completion) {
        completion(response);
    }
}

- (void)requestDidSucceedWithDataTask:(NSURLSessionTask *)task responseObject:(id)responseObject{
    FYResponse *response = [[FYResponse alloc] initWithResponseData:responseObject requestTask:task error:nil];
    Lock();
    FYRequestCompletionHander completion =  [self.taskCompletionMapper objectForKey:@(task.taskIdentifier)];
    Unlock();
    if (completion) {
        completion(response);
    }
}
@end
