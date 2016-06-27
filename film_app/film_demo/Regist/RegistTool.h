//
//  RegistTool.h
//  clouclip
//
//  Created by rejoin on 15/9/16.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"
#import "Common.h"

@interface RegistTool : NSObject

/**
 * 用户注册
 */
+ (void)registWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password SUCCESS:(SuccessBlock)SUCCESS DBERROR:(FailBlock)DBERROR;


@end
