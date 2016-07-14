//
//  LySandBoxPath.m
//  jiawo
//
//  Created by 李岳 on 16/3/4.
//  Copyright © 2016年 ZHE JIANG ASUN PROPERTY MANAGEMENT. All rights reserved.
//

#import "LySandBoxPath.h"

@implementation LySandBoxPath
+ (NSString *)getCachesDirectory{
    
    NSString * paths = [ NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    return paths;

}
+ (NSString *)getTmpDirectory{
    return NSTemporaryDirectory();
}
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
