//
//  LoginTool.m
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "LoginTool.h"
#import "User.h"

@implementation LoginTool

#pragma mark 用户登陆

+ (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR
{
    // 1.打包参数
    NSDictionary * dict=@{@"phoneNumber":phoneNumber,@"password":password};
    //2.POST请求
    [HttpTool postWithUrl:KloginURL params:dict contentType:@"application/json" SUCCESS:^(id responseObject) {
        if (SUCCESS) {
            SUCCESS(responseObject);
            MyLog(@"login=responseObject==%@",responseObject);
        }
    } DBERROR:^(NSError *error) {
        if (DBERROR) {
            DBERROR(error);
            MyLog(@"login=error==%@",error.localizedDescription);
        }
    }];
}

@end
