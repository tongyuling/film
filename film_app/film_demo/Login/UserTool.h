//
//  UserTool.h
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class User;
@interface UserTool : NSObject

single_interface(UserTool)

/**
 * 保存用户
 **/
- (void)saveUser:(User *)user;

/**
 * 访问用户
 **/
@property (nonatomic, strong, readonly) User *user;


@end
