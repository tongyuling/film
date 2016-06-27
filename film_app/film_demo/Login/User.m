//
//  User.m
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithPhoneN:(NSString *)phoneNumber password:(NSString *)password token:(NSString *)token
{
    if (self=[super init]) {
        _password = password;
        _phoneNumber=phoneNumber;
        _token=token;
    }
    
    return self;
}



@end
