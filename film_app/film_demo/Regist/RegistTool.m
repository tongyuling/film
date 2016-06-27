//
//  RegistTool.m
//  clouclip
//
//  Created by rejoin on 15/9/16.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "RegistTool.h"
#import "User.h"

@implementation RegistTool

#pragma mark 用户注册

+ (void)registWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR
{
    // 1.封装参数
    NSDictionary * dict = @{@"phoneNumber":phoneNumber, @"password":password};
    //2.POST请求
    [HttpTool postWithUrl:KregistUrl params:dict contentType:@"application/json" SUCCESS:^(id responseObject) {
        if (SUCCESS) {
            SUCCESS(responseObject);
            MyLog(@"regist=responseObject==%@",responseObject);
        }
    } DBERROR:^(NSError *error) {
        if (DBERROR) {
            DBERROR(error);
            MyLog(@"regist=error==%@",error.localizedDescription);
        }
    }];
}

@end
