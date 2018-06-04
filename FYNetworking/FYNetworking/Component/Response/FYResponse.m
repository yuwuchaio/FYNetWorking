//
//  FYResponse.m
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "FYResponse.h"

@interface FYResponse ()

@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;
@property (nonatomic, strong, readwrite, nullable) id responseJSONObject;
@property (nonatomic, copy, readwrite) NSString *responseString;
@property (nonatomic, strong, readwrite, nullable) NSError *error;

@end

@implementation FYResponse
- (instancetype)initWithResponseData:(NSData *)responseData requestTask:(NSURLSessionTask *)requestTask error:(NSError *)error {
    if (self = [super init]) {
        self.error = error;
        self.requestTask = requestTask;
        self.responseData = responseData;
        self.responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (responseData) {
            self.responseJSONObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        }
    }
    return self;
}
@end
