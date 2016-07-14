//
//  FirstController.m
//  film_demo
//
//  Created by rejoin on 15/5/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "FirstController.h"
#import "Common.h"
#import "AdView.h"
#import "CollectionController.h"
#import "LoginController.h"
#import "ThirdController.h"
#import "User.h"
#import "UserTool.h"
#import "LyCleanCaches.h"
#import "LySandBoxPath.h"

@interface FirstController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIImageView * _imageView;
    AdView * adView;
}

@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=KcolorRGB(234, 80, 62);
    
    //去掉导航栏下面的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    [self buildUI];
}


-(void)buildUI
{
    UIView * view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, KviewWidth, 64);
    [self.view addSubview:view1];
    
    UILabel * label1=[[UILabel alloc]init];
    label1.frame=CGRectMake(KviewWidth/2.67, KviewHeight/17.2, KviewWidth/4, KviewHeight/28.4);
    label1.textAlignment=NSTextAlignmentCenter;
    label1.text=@"图像大师";
    label1.textColor=[UIColor whiteColor];
    [view1 addSubview:label1];
    
    UIButton * btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone4) {
        btn1.frame=CGRectMake(KviewWidth/2.9, 60, KviewWidth/3.2, KviewHeight/5.68);
    }
    if (iPhone5) {
        btn1.frame=CGRectMake(KviewWidth/2.9, 80, KviewWidth/3.2, KviewHeight/5.68);
    }
    if (iPhone6) {
        btn1.frame=CGRectMake(KviewWidth/2.9, 100, KviewWidth/3.2, KviewHeight/5.68);
    }
    if (iPhone6p) {
        btn1.frame=CGRectMake(KviewWidth/2.9, 110, KviewWidth/3.2, KviewHeight/5.68);
    }
    btn1.layer.masksToBounds=YES;
    btn1.layer.cornerRadius=8;
    [btn1 setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [btn1.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref1 = CGColorCreate(colorSpace1,(CGFloat[]){ 1, 1, 1, 1 });
    [btn1.layer setBorderColor:colorref1];//边框颜色
    [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone4) {
        btn2.frame=CGRectMake(btn1.frame.origin.x-80, CGRectGetMaxY(btn1.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone5) {
        btn2.frame=CGRectMake(btn1.frame.origin.x-80, CGRectGetMaxY(btn1.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6) {
        btn2.frame=CGRectMake(btn1.frame.origin.x-80, CGRectGetMaxY(btn1.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6p) {
        btn2.frame=CGRectMake(btn1.frame.origin.x-80, CGRectGetMaxY(btn1.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    btn2.layer.masksToBounds=YES;
    btn2.layer.cornerRadius=8;
    [btn2 setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    [btn2.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace2 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref2 = CGColorCreate(colorSpace2,(CGFloat[]){ 1, 1, 1, 1 });
    [btn2.layer setBorderColor:colorref2];//边框颜色
    [btn2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton * btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone4) {
        btn3.frame=CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn2.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone5) {
        btn3.frame=CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn2.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6) {
        btn3.frame=CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn2.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6p) {
        btn3.frame=CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn2.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    [btn3 setImage:[UIImage imageNamed:@"beaker"] forState:UIControlStateNormal];
    [btn3.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace3 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref3 = CGColorCreate(colorSpace3,(CGFloat[]){ 1, 1, 1, 1 });
    [btn3.layer setBorderColor:colorref3];//边框颜色
    btn3.layer.masksToBounds=YES;
    btn3.layer.cornerRadius=8;
    [btn3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton * btn4=[UIButton buttonWithType:UIButtonTypeCustom];
    if (iPhone4) {
        btn4.frame=CGRectMake(btn1.frame.origin.x+80, CGRectGetMaxY(btn3.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone5) {
        btn4.frame=CGRectMake(btn1.frame.origin.x+80, CGRectGetMaxY(btn3.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6) {
        btn4.frame=CGRectMake(btn1.frame.origin.x+80, CGRectGetMaxY(btn3.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    if (iPhone6p) {
        btn4.frame=CGRectMake(btn1.frame.origin.x+80, CGRectGetMaxY(btn3.frame)+20, btn1.frame.size.width,btn1.frame.size.height);
    }
    btn4.layer.masksToBounds=YES;
    btn4.layer.cornerRadius=8;
    [btn4 setImage:[UIImage imageNamed:@"puzzle"] forState:UIControlStateNormal];
    [btn4.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace4 = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref4 = CGColorCreate(colorSpace4,(CGFloat[]){ 1, 1, 1, 1 });
    [btn4.layer setBorderColor:colorref4];//边框颜色
    [btn4 addTarget:self action:@selector(btn4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}


-(void)btn1
{
    UIImagePickerController * imageP=[[UIImagePickerController alloc]init];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此设备不支持拍照功能" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:^{
        }];
            
        return;
    }
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 拍照
        imageP.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    
    // 允许编辑
    imageP.allowsEditing=YES;
    // 设置代理
    imageP.delegate=self;
    // 显示照片选择控制器
    [self presentViewController:imageP animated:YES completion:nil];
}

-(void)btn2
{
    UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CollectionController * scan=[stroy instantiateViewControllerWithIdentifier:@"scan"];
    [self.navigationController pushViewController:scan animated:YES];
}

-(void)btn3
{
    ThirdController * third=[[ThirdController alloc]init];
    [self.navigationController pushViewController:third animated:YES];
}

-(void)btn4
{
//    NSString * cachePath = [LySandBoxPath getCachesDirectory];
//    double number = [LyCleanCaches sizeWithFilePath:cachePath];
//    NSString * m = [NSString stringWithFormat:@"%.2f",number];
//    NSString * message = [NSString stringWithFormat:@"%@M",m];
//    
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"清除" otherButtonTitles:nil, nil];
//    [alert show];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        LoginController * login=[[LoginController alloc]init];
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:login];
        self.view.window.rootViewController=nav;
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alert animated:YES completion:^{
    }];
    
}

//清除
//- (void)alertViewCancel:(UIAlertView *)alertView
//{
//    //清缓存
//    [LyCleanCaches clearCachesFromDirectoryPath:[LySandBoxPath getCachesDirectory]];
//}


#pragma mark UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.设置头像
    _imageView.image=info[UIImagePickerControllerEditedImage];
    // 保存图片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    //2.关闭控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
