//
//  FYRequestBuilder.m
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYRequestBuilder.h"
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
    }
    return self;
}

- (NSURLRequest *)buildRequetWithHTTPMethod:(FYRequestMethod)method URLString:(NSString *)URLString requestSerializerType:(FYRequestSerializerType)serializerType parameters:(id)parameters headers:(NSDictionary *)headers {
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
    
    // return NSURLRequest
    switch (method) {
        case FYRequestMethodPOST:
            return nil;
        case FYRequestMethodGET:
            return [requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
        case FYRequestMethodHEAD:
            return [requestSerializer requestWithMethod:@"HEAD" URLString:URLString parameters:parameters error:nil];
        case FYRequestMethodPUT:
            return [requestSerializer requestWithMethod:@"PUT" URLString:URLString parameters:parameters error:nil];
        case FYRequestMethodDELETE:
            return [requestSerializer requestWithMethod:@"DELETE" URLString:URLString parameters:parameters error:nil];
            case FYRequestMethodPATCH:
            return [requestSerializer requestWithMethod:@"PATCH" URLString:URLString parameters:parameters error:nil];
    }
}

@end
