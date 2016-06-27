//
//  LoginTool.h
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"
#import "Common.h"

@class User;

@interface LoginTool : NSObject

/**
 * 用户登陆
 */
+ (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR;


@end
