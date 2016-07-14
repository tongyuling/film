//
//  LySandBoxPath.h
//  jiawo
//
//  Created by 李岳 on 16/3/4.
//  Copyright © 2016年 ZHE JIANG ASUN PROPERTY MANAGEMENT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LySandBoxPath : NSObject
//获取沙盒Library/Caches文件路径
+ (NSString *)getCachesDirectory;


+ (NSString *)getTmpDirectory;



// 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory;

+ (NSString *)getDocumentDirectory;
@end
