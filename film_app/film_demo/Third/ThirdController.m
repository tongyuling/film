//
//  ThirdController.m
//  film_demo
//
//  Created by rejoin on 15/10/13.
//  Copyright © 2015年 rejoin. All rights reserved.
//

#import "ThirdController.h"
#import "Common.h"

@interface ThirdController ()

@end

@implementation ThirdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //添加左导航栏按钮
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backThird)];
    UIColor * color=KcolorRGB(234, 80, 62);
    [leftBtn setTintColor:color];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    [self buildUI];
}


-(void)buildUI
{
    UIView * view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, KviewWidth, KviewHeight);
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    UIImageView * imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(KviewWidth/3.76, KviewHeight/9.47, KviewWidth/2.13, KviewHeight/3.79);
    imageView.image=[UIImage imageNamed:@"icon"];
    [self.view addSubview:imageView];
    
    NSMutableString * strTop=[[NSMutableString alloc]initWithString:@"        图片大师是一款集拍照和本地图片设置等功能的一款很不错的APP！        每天打开图片大师您都会发现不一样的功能和体验！        图片大师是您的不二选择。"];
    [strTop insertString:@"\n\n" atIndex:39];
    [strTop insertString:@"\n\n" atIndex:72];
    NSString * str=[NSString stringWithFormat:@"%@",strTop];
    
    UILabel * label=[[UILabel alloc]init];
    if (iPhone4) {
        label.frame=CGRectMake(KviewWidth/16, KviewHeight/2.58, KviewWidth/1.14, KviewHeight/3.79+50);
    }
    else{
        label.frame=CGRectMake(KviewWidth/16, KviewHeight/2.58, KviewWidth/1.14, KviewHeight/3.79);
    }
    label.textColor=[UIColor lightGrayColor];
    label.text=str;
    label.numberOfLines=0;
    [self.view addSubview:label];
}


#pragma mark 返回btn
-(void)backThird
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
