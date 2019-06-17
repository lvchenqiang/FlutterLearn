//
//  AsrManager.h
//  Runner
//
//  Created by 吕陈强 on 2019/6/17.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AsrCallBack)(NSString * message);

NS_ASSUME_NONNULL_BEGIN

@interface AsrManager : NSObject

+(instancetype)initWithCallBck:(AsrCallBack)success faliure:(AsrCallBack)failure;

- (void)start;

-(void)stop;


-(void)cancel;


@end

NS_ASSUME_NONNULL_END
