//
//  Common.h
//  ble4.0
//
//  Created by rejoin on 15/5/18.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#ifndef ble4_0_Common_h
#define ble4_0_Common_h

// 自定义Log
#ifdef DEBUG // 调试状态, 打开LOG功能
#define MyLog(...) NSLog(__VA_ARGS__)
#else // 发布状态, 关闭LOG功能
#define MyLog(...)
#endif


//判断尺寸
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//适配
#define KAdaptationView(View,iPhone4X,iPhone4Y,iPhone4W,iPhone4H,otherX,otherY,otherW,otherH) if (iPhone4) {View.frame=CGRectMake(iPhone4X, iPhone4Y, iPhone4W, iPhone4H);}else{View.frame=CGRectMake(otherX, otherY, otherW, otherH);}


//全局大小
#define KviewWidth [UIScreen mainScreen].bounds.size.width
#define KviewHeight [UIScreen mainScreen].bounds.size.height
//主控制器布局
#define labelDistance 5
#define textFieldHeight 48

//rgb颜色
#define KcolorRGB(x,y,z) [UIColor colorWithRed:(x/255.0f) green:(y/255.0f)blue:(z/255.0f) alpha:1.0f];

#define  KColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//0.相同url
#define KURL @"http://www.clouclip.com:8080/clouclip/services/v1/user/"
//1.登陆url
#define KloginURL [NSString stringWithFormat:@"%@login",KURL]
//2.注册url
#define KregistUrl [NSString stringWithFormat:@"%@register",KURL]
//3.设置信息url
#define KuserinfoUrl [NSString stringWithFormat:@"%@updateUserInfo",KURL]
//4.获取设置信息url
#define KgetuserinfoUrl [NSString stringWithFormat:@"%@getUserInfo",KURL]
//5.获取眼部数据url
#define KgetdataUrl [NSString stringWithFormat:@"%@getUserEyeInfo",KURL]
//6.上传眼部数据url
#define KpushdataUrl [NSString stringWithFormat:@"%@updateUserEyeInfo",KURL]
//7.上传用眼数据url
#define KpushUrl [NSString stringWithFormat:@"%@addUserEnvData",KURL]
//8.获取当前用眼分数url
#define KgetscoreUrl [NSString stringWithFormat:@"%@getUserSumCur",KURL]
//9.最近7次用眼分数(小时)
#define KgethourtrendUrl [NSString stringWithFormat:@"%@getUserSumPerHour",KURL]
//10.最近7次用眼分数(天)
#define KgetdaytrendUrl [NSString stringWithFormat:@"%@getUserSumPerDay",KURL]
//11.趋势当前用眼环境数据
#define KgetAnalysisNewUrl [NSString stringWithFormat:@"%@getUserEnvCur",KURL]
//12.趋势综合用眼环境数据
#define KgetAnalysisComprehensiveUrl [NSString stringWithFormat:@"%@getUserEnv",KURL]


//数据库参数
#define TABLENAME   @"info"
#define DBNAME      @"info.sqlite"
#define TIME        @"time"
#define UV          @"uv"
#define LUX         @"lux"
#define PROXIMITY   @"proximity"
#define ANGLE_X     @"angle_x"
#define ANGLE_Y     @"angle_y"
#define ANGLE_Z     @"angle_z"
#define IS_ELEC     @"is_elec"

#endif
