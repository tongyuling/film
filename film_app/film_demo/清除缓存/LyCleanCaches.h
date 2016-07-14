//
//  LyCleanCaches.h
//  jiawo
//
//  Created by 李岳 on 16/3/4.
//  Copyright © 2016年 ZHE JIANG ASUN PROPERTY MANAGEMENT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyCleanCaches : NSObject
//根据路径返回目录或文件的大小
+ (double)sizeWithFilePath:(NSString *)path;

+ (NSArray *)getAllFileNames:(NSString *)dirPath;

+(BOOL)clearCachesWithFilePath:(NSString *)path;

+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;
@end
