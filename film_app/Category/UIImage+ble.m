//
//  UIImage+ble.m
//  ble4.0
//
//  Created by rejoin on 15/5/12.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "UIImage+ble.h"
#import "NSString+ble.h"

@implementation UIImage (ble)

#pragma mark 加载全屏图片
+(UIImage *)fullScreenImage:(NSString *)image
{
    //判断屏幕大小
    //iphone4、4s
    if ([UIScreen mainScreen].bounds.size.height == 480 )
    {
        image = [image fileAppend:@""];
    }
    //iphone5、5s
    if ([UIScreen mainScreen].bounds.size.height == 568 )
    {
        image = [image fileAppend:@""];
    }
    //iphone6
    if ([UIScreen mainScreen].bounds.size.height == 667 && [UIScreen mainScreen].bounds.size.width == 375)
    {
        image = [image fileAppend:@""];
    }
    //iphone6Plus
    if ([UIScreen mainScreen].bounds.size.height == 960 && [UIScreen mainScreen].bounds.size.width == 540)
    {
        image = [image fileAppend:@""];
    }
    return [self imageNamed:image];
}

@end
