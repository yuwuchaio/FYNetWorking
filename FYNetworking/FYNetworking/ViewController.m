//
//  ViewController.m
//  FYNetworking
//
//  Created by FishYu on 2018/5/21.
//  Copyright © 2018年 FishYu. All rights reserved.
//

#import "ViewController.h"
#import "FYNetworkAgent.h"
#import "FYNetworkConfig.h"
#import "FYRequestBuilder.h"
#import "FYResponse.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dict = [NSMutableDictionary dictionaryWithCapacity:2];
    self.dict[@"1"] = nil;
    
    [FYNetworkConfig sharedConfig].baseURL = @"https://test.88gongxiang.com/";
    [FYRequestBuilder shareBuilder].globalHeaders = @{ @"x-app-version" : @"1.9.0",
                                                       @"x-auth-token" : @"60FAB07AEB68598C46F7E93A545ED3A9",
                                                       }.mutableCopy;
    NSLog(@"%@",self.dict[@"1"]);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     
}


@end
