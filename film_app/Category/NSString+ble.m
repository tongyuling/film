//
//  NSString+ble.m
//  ble4.0
//
//  Created by rejoin on 15/5/12.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "NSString+ble.h"

@implementation NSString (ble)

#pragma mark 在字符串后面追加内容
- (NSString *)fileAppend:(NSString *)append
{
    NSString *imageStr = nil;
    //1.1.获取后缀名
    NSString *ext = [self pathExtension];
    if (![@"" isEqualToString:ext])
    {   //后缀名不为空
        //1.2.删除后缀名
        imageStr = [self stringByDeletingPathExtension];
        //1.3.追加内容
        imageStr = [imageStr stringByAppendingString:append];
        //1.4.追加后缀名
        imageStr = [imageStr stringByAppendingPathExtension:ext];
    }
    else
    {//后缀名为空
        imageStr = [self stringByAppendingString:append];
    }
    return imageStr;
}

#pragma mark 去掉字符串的空格
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否是空字符串
- (BOOL)isEmptyString {
    return (self.length == 0);
}



- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



@end
