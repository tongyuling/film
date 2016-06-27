//
//  UserTool.m
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "UserTool.h"
#import "User.h"

@implementation UserTool

single_implementation(UserTool)

#pragma mark 保存用户
- (void)saveUser:(User *)user
{

    [[NSUserDefaults standardUserDefaults]setObject:user.phoneNumber forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults]setObject:user.password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]setObject:user.token forKey:@"token"];

    
    //同步
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 访问用户
- (User *)user {
    User *user = [[User alloc] init];
    user.phoneNumber=[[NSUserDefaults standardUserDefaults] stringForKey:@"phoneNumber"];
    user.password=[[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    user.token=[[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    
    return user;
}

@end
