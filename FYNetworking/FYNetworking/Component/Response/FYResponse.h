//
//  FYResponse.h
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 the result of request
 */
@interface FYResponse : NSObject

///  The response status code.
@property (nonatomic, readonly) NSInteger code;
///  The underlying NSURLSessionTask.
@property (nonatomic, strong, readonly) NSURLSessionTask *requestTask;
/// the JSON representation of respone.Note this value can be nil if JSON Serialize failed.
@property (strong, nonatomic, readonly, nullable) id responseJSONObject;
///  The raw data representation of response. Note this value can be nil if request failed.
@property (nonatomic, copy, readonly) NSData *responseData;
/// The string representation of response. Note this value can be nil if request failed.
@property (nonatomic, copy, readonly) NSString *responseString;
///  This error can be either serialization error or network error. If nothing wrong happens
///  this value will be nil.
@property (nonatomic, strong, readonly, nullable) NSError *error;

// initialize
- (instancetype)initWithResponseData:(NSData *)responseData requestTask:(NSURLSessionTask *)requestTask error:(NSError *)error;

@end
NS_ASSUME_NONNULL_END
