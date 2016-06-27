//
//  HttpTool.h
//  ble4.0
//
//  Created by rejoin on 15/4/20.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(id responseObject); // 成功时回调的代码块
typedef void(^FailBlock)(NSError *error); // 失败时回调的代码块

@interface HttpTool : NSObject



+ (void)postWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR;


+(void)getWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR;


@end
