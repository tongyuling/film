//
//  User.h
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (copy,nonatomic) NSString * phoneNumber;//用户账号
@property (copy,nonatomic) NSString * password;//用户密码
@property (copy,nonatomic) NSString * token;//令牌

-(id)initWithPhoneN:(NSString *)phoneNumber password:(NSString *)password token:(NSString *)token;


@end
