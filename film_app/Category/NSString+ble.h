//
//  NSString+ble.h
//  ble4.0
//
//  Created by rejoin on 15/5/12.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ble)

#pragma mark 字符串后面追加内容
- (NSString *)fileAppend:(NSString *)append;

/**
 ** 去掉字符串的空格
 **/
- (NSString *)trimString;

/**
 ** 是否是空字符串
 **/
- (BOOL)isEmptyString;



- (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
