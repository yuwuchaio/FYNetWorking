//
//  FYRequestBuilder.h
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import <Foundation/Foundation.h>
// HTTP Request method.
typedef NS_ENUM(NSInteger, FYRequestMethod) {
    FYRequestMethodGET = 0,
    FYRequestMethodPOST,
    FYRequestMethodHEAD,
    FYRequestMethodPUT,
    FYRequestMethodDELETE,
    FYRequestMethodPATCH,
};

//  Request serializer type.
typedef NS_ENUM(NSInteger,FYRequestSerializerType) {
    FYRequestSerializerTypeHTTP = 0,
    FYRequestSerializerTypeJSON,
};

/**
 the bulder of request，
 */
@interface FYRequestBuilder : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

// singleton Object
+ (instancetype)shareBuilder;
// global headers default is empty dictionary
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *globalHeaders;

// initializer
- (NSURLRequest *)buildRequetWithHTTPMethod:(FYRequestMethod)method URLString:(NSString *)URLString requestSerializerType:(FYRequestSerializerType)serializerType parameters:(id)parameters headers:(NSDictionary *)headers;

@end
