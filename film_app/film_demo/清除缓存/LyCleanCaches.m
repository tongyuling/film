//
//  LyCleanCaches.m
//  jiawo
//
//  Created by 李岳 on 16/3/4.
//  Copyright © 2016年 ZHE JIANG ASUN PROPERTY MANAGEMENT. All rights reserved.
//

#import "LyCleanCaches.h"

@implementation LyCleanCaches
+ (double)sizeWithFilePath:(NSString *)path{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    //检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [manager fileExistsAtPath:path isDirectory:&dir];
    if (!exits) {
        return 0;
    }
    
// 判断是否为文件夹
    else {
        NSArray * subPaths = [manager subpathsAtPath:path];
        if (subPaths.count != 0) {
            int totalSize = 0;
            for (NSString * subpath  in subPaths) {
                NSString * fullsubpath = [path stringByAppendingPathComponent:subpath];
                BOOL dir = NO;
                [manager fileExistsAtPath:fullsubpath isDirectory:&dir];
                if (!dir) {
                    NSDictionary * attrs = [manager attributesOfItemAtPath:fullsubpath error:nil];
                    totalSize += [attrs[NSFileSize] intValue];
                }
            }
            return totalSize/(1024*1024.0);

        }else{
            NSDictionary * attrs = [manager attributesOfItemAtPath:path error:nil];
            return [attrs[NSFileSize]intValue]/(1024*1024.0);
            
        }
    }
    
}

#pragma mark ****************清缓存***************

+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath{
    //获得全部文件数组
    NSArray * fileAry = [LyCleanCaches getAllFileNames:dirPath];
    BOOL flag = NO;
    for (NSString * fileName in fileAry) {
        NSString * filePath = [dirPath stringByAppendingPathComponent:fileName];
        flag = [LyCleanCaches clearCachesWithFilePath:filePath];
//        if (!flag) {
//            break;
//        }
        
    }
    return flag;
}

//得到指定目录下的所有文件
+ (NSArray * )getAllFileNames:(NSString *)dirPath{
    NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:dirPath];
    return files;
}

//删除指定目录或文件
+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    BOOL isClear = NO;
    NSError * error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
     isClear = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    }
    if (error) {
        NSLog(@"error = %@",error.description);
    }
    return isClear;
}
@end
