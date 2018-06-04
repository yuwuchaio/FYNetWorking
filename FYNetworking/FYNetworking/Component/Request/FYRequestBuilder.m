//
//  FYRequestBuilder.m
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYRequestBuilder.h"
#import "FYNetworkConfig.h"
#import "AFNetworking.h"
#if __has_include(<AFNetworking/AFURLRequestSerialization.h>)
#import <AFNetworking/AFURLRequestSerialization.h>
#else
#import "AFURLRequestSerialization.h"
#endif

@interface FYRequestBuilder ()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;
@end

@implementation FYRequestBuilder

+ (instancetype)shareBuilder {
    static dispatch_once_t onceToken;
    static FYRequestBuilder *shareBuilder;
    dispatch_once(&onceToken, ^{
        shareBuilder = [[self alloc] init];
    });
    return shareBuilder;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        _globalHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSURLRequest *)buildRequetWithHTTPMethod:(FYRequestMethod)method URLString:(NSString *)URLString requestSerializerType:(FYRequestSerializerType)serializerType parameters:(id)parameters constructingBodyBlock:(AFConstructingBlock)block headers:(NSDictionary *)headers error:(NSError *__autoreleasing  _Nullable *)error{
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (serializerType == FYRequestSerializerTypeHTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (serializerType == FYRequestSerializerTypeJSON) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    NSDictionary<NSString *, NSString *> *globalHeaders = [FYRequestBuilder shareBuilder].globalHeaders;
    
    // configure request header
    NSMutableDictionary *headerFieldValueDictionary = [NSMutableDictionary dictionaryWithDictionary:globalHeaders];
    [headerFieldValueDictionary addEntriesFromDictionary:headers];
    if (headerFieldValueDictionary.allKeys.count != 0) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    URLString = [self getCompleteURL:URLString];
    // return NSURLRequest
    switch (method) {
        case FYRequestMethodPOST:
            if (block) {
                return  [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parameters constructingBodyWithBlock:block error:error];
            } else {
                return [requestSerializer requestWithMethod:@"POST" URLString:URLString parameters:parameters error:error];
            }
        case FYRequestMethodGET:
            return [requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:error];
        case FYRequestMethodHEAD:
            return [requestSerializer requestWithMethod:@"HEAD" URLString:URLString parameters:parameters error:error];
        case FYRequestMethodPUT:
            return [requestSerializer requestWithMethod:@"PUT" URLString:URLString parameters:parameters error:error];
        case FYRequestMethodDELETE:
            return [requestSerializer requestWithMethod:@"DELETE" URLString:URLString parameters:parameters error:error];
            case FYRequestMethodPATCH:
            return [requestSerializer requestWithMethod:@"PATCH" URLString:URLString parameters:parameters error:error];
    }
}

// get Complete URL
- (NSString *)getCompleteURL:(NSString *)detailUrl{
    
    NSURL *temp = [NSURL URLWithString:detailUrl];
    // If detailUrl is valid URL
    if (temp && temp.host && temp.scheme) {
        return detailUrl;
    }
    NSString *baseUrl = [[FYNetworkConfig sharedConfig] baseURL];
    // URL slash compability
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    if (baseUrl.length > 0 && ![baseUrl hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    return [NSURL URLWithString:detailUrl relativeToURL:url].absoluteString;
}
@end
