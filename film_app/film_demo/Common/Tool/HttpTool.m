//
//  HttpTool.m
//  ble4.0
//
//  Created by rejoin on 15/4/20.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "HttpTool.h"
#import "Common.h"

@implementation HttpTool

+(void)getWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR
{
    // 1.创建Http请求操作管理器
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.设置返回类型
    if (type) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    }
    // 3.创建Http请求操作对象
    AFHTTPRequestOperation * op=[manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (SUCCESS) { //success不为空
            SUCCESS(responseObject);
            
            MyLog(@"responseObject==%@",responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (DBERROR) { //fail不为空
            DBERROR(error);
            MyLog(@"error==%@",error);
        }
    }];
    // 4.发送请求
    [op start];

}


+ (void)postWithUrl:(NSString *)urlStr params:(NSDictionary *)params contentType:(NSString *)type SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR {
    // 1.创建Http请求操作管理器
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.设置返回类型
    if (type) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:type];
    }
    // 3.创建Http请求操作对象
    AFHTTPRequestOperation *op = [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (SUCCESS) { //success不为空
            SUCCESS(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (DBERROR) { //fail不为空
            DBERROR(error);
        }
    }];
    // 4.发送请求
    [op start];
}

@end
