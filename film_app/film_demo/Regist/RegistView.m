//
//  RegistView.m
//  clouclip
//
//  Created by rejoin on 15/9/21.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "RegistView.h"
#import "Common.h"

@implementation RegistView

- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}


-(void)buildUI
{
    UIColor * color=KcolorRGB(234, 80, 62);
    
    //backBtn
    _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame=CGRectMake(KviewWidth/16, KviewHeight/14.2, KviewWidth/17.8, KviewHeight/31.6);
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"Regist_back"] forState:UIControlStateNormal];
    [self addSubview:_backBtn];
    
    //标题
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(KviewWidth/2.37, _backBtn.frame.origin.y-5, KviewWidth/6.4, KviewHeight/22.72);
    label.text=@"注册";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:18];
    [self addSubview:label];
    
    //userText
    _phoneNumberText=[[UITextField alloc]init];
    _phoneNumberText.frame=CGRectMake(KviewWidth/9.28, KviewHeight/4.5, KviewWidth/1.27, KviewHeight/22.3);
    _phoneNumberText.placeholder=@"请输入11位手机号码";
    _phoneNumberText.keyboardType=UIKeyboardTypeNumberPad;
    [self addSubview:_phoneNumberText];
    
    //line1
    UIImageView * line1=[[UIImageView alloc]init];
    line1.image=[UIImage imageNamed:@"Login_line"];
    line1.frame=CGRectMake(_phoneNumberText.frame.origin.x, CGRectGetMaxY(_phoneNumberText.frame)+11, _phoneNumberText.frame.size.width, 1);
    [self addSubview:line1];

    //passwordText1
    _passwordText=[[UITextField alloc]init];
    _passwordText.frame=CGRectMake(_phoneNumberText.frame.origin.x, CGRectGetMaxY(line1.frame)+20, line1.frame.size.width, KviewHeight/22.3);
    _passwordText.placeholder=@"请输入6-12位密码";
    _passwordText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [_passwordText setSecureTextEntry:YES];
    [self addSubview:_passwordText];
    
    //line3
    UIImageView * line3=[[UIImageView alloc]init];
    line3.image=[UIImage imageNamed:@"Login_line"];
    line3.frame=CGRectMake(_passwordText.frame.origin.x, CGRectGetMaxY(_passwordText.frame)+20,_passwordText.frame.size.width, 1);
    [self addSubview:line3];
    
    //passwordText2
    _passwordText1=[[UITextField alloc]init];
    _passwordText1.frame=CGRectMake(line3.frame.origin.x, CGRectGetMaxY(line3.frame)+20, line3.frame.size.width, KviewHeight/22.3);
    _passwordText1.placeholder=@"请确定密码";
    _passwordText1.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [_passwordText1 setSecureTextEntry:YES];
    [self addSubview:_passwordText1];
    
    //line4
    UIImageView * line4=[[UIImageView alloc]init];
    line4.image=[UIImage imageNamed:@"Login_line"];
    line4.frame=CGRectMake(_passwordText1.frame.origin.x, CGRectGetMaxY(_passwordText1.frame)+20, _passwordText1.frame.size.width, 1);
    [self addSubview:line4];
    
    //注册btn
    _registbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _registbtn.frame=CGRectMake(KviewWidth/10.7, CGRectGetMaxY(line4.frame)+50, KviewWidth/1.23, KviewHeight/13.2);
    [_registbtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registbtn setBackgroundColor:color];
    _registbtn.alpha=0.8;
    [_registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_registbtn];
    
    //已有账号btn
    _haveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _haveBtn.frame=CGRectMake(_registbtn.frame.size.width/5*4, CGRectGetMaxY(_registbtn.frame)+5, KviewWidth/4, KviewHeight/18.9);
    _haveBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_haveBtn setTitle:@"已有账号登陆" forState:UIControlStateNormal];
    [_haveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_haveBtn];
}


@end
