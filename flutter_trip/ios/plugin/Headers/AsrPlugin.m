//
//  AsrPlugin.m
//  Runner
//
//  Created by 吕陈强 on 2019/6/17.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "AsrPlugin.h"
#import "AsrManager.h"
@interface AsrPlugin ()

@property (nonatomic, strong ) AsrManager * manager;
@property (nonatomic, copy) FlutterResult result;

@end

@implementation AsrPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
{
    FlutterMethodChannel * chanel = [FlutterMethodChannel methodChannelWithName:@"asr_plugin" binaryMessenger:[registrar messenger]];
    
    AsrPlugin * plugin = [AsrPlugin new];
    [registrar addMethodCallDelegate:plugin channel:chanel];
    
    
}


- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result
{
    if([@"start"  isEqualToString:call.method]){
        [self.manager start];
        
    }else if([@"cancel" isEqualToString:call.method]){
        [self.manager cancel];
        
    }else if ([@"stop" isEqualToString:call.method]){
        [self.manager stop];
    }else
    {
        NSLog(@"为实现");
    }
    
}


- (AsrManager *)manager
{
    if(!_manager){
        _manager = [AsrManager initWithCallBck:^(NSString *message) {
            if(self.result){
                self.result(message);
                self.result = nil;
            }
        } faliure:^(NSString *message) {
            if(self.result){
                self.result([FlutterError errorWithCode:@"asr failure" message:message details:nil]);
                self.result = nil;
            }
        }];
    }
    return _manager;
}
@end
