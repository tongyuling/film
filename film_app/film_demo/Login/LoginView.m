//
//  LoginView.m
//  clouclip
//
//  Created by rejoin on 15/9/21.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "LoginView.h"
#import "Common.h"

@implementation LoginView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}


-(void)buildUI
{
    //icon
    UIImageView * icon=[[UIImageView alloc]init];
    if (iPhone4) {
        icon.frame=CGRectMake(KviewWidth/2.95-15, KviewHeight/4.85-40, KviewWidth/3.12+40, KviewHeight/9.02+60);
    }
    if (iPhone5) {
        icon.frame=CGRectMake(KviewWidth/2.95-25, KviewHeight/4.85-60, KviewWidth/3.12+60, KviewHeight/9.02+80);
    }
    if (iPhone6) {
        icon.frame=CGRectMake(KviewWidth/2.95-35, KviewHeight/4.85-80, KviewWidth/3.12+80, KviewHeight/9.02+100);
    }
    if (iPhone6p) {
        icon.frame=CGRectMake(KviewWidth/2.95-45, KviewHeight/4.85-100, KviewWidth/3.12+100, KviewHeight/9.02+120);
    }
    icon.image=[UIImage imageNamed:@"icon"];
    [self addSubview:icon];
    
    //用户名icon
    UIImageView * userIcon=[[UIImageView alloc]init];
    userIcon.image=[UIImage imageNamed:@"Login_user"];
    userIcon.frame=CGRectMake(KviewWidth/9.55, KviewHeight/2.03, KviewWidth/20, KviewHeight/35.5);
    [self addSubview:userIcon];
    
    //用户text
    _phoneNumberText=[[UITextField alloc]init];
    _phoneNumberText.frame=CGRectMake(CGRectGetMaxX(userIcon.frame)+KviewWidth/20, userIcon.frame.origin.y-5, KviewWidth/1.44,KviewHeight/22.3);
    _phoneNumberText.font=[UIFont systemFontOfSize:16];
    _phoneNumberText.placeholder=@"Username";
    _phoneNumberText.keyboardType=UIKeyboardTypeNumberPad;
    [self addSubview:_phoneNumberText];
    
    //分割线1
    UIImageView * imageLine1=[[UIImageView alloc]init];
    imageLine1.frame=CGRectMake(KviewWidth/4.92, KviewHeight/1.89, _phoneNumberText.frame.size.width, 1);
    imageLine1.image=[UIImage imageNamed:@"Login_line"];
    [self addSubview:imageLine1];
    
    //密码icon
    UIImageView * passwordIcon=[[UIImageView alloc]init];
    passwordIcon.image=[UIImage imageNamed:@"Login_password"];
    passwordIcon.frame=CGRectMake(userIcon.frame.origin.x, KviewHeight/1.75, userIcon.frame.size.width, userIcon.frame.size.height);
    [self addSubview:passwordIcon];
    
    //密码text
    _passwordText=[[UITextField alloc]init];
    _passwordText.frame=CGRectMake(_phoneNumberText.frame.origin.x, KviewHeight/1.775, _phoneNumberText.frame.size.width-17, _phoneNumberText.frame.size.height);
    _passwordText.font=[UIFont systemFontOfSize:16];
    _passwordText.placeholder=@"Password";
    _passwordText.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self.passwordText setSecureTextEntry:YES];
    [self addSubview:_passwordText];
    
    //问号btn
    _forgotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _forgotBtn.frame=CGRectMake(CGRectGetMaxX(_passwordText.frame), _passwordText.frame.origin.y, KviewWidth/18.8, KviewHeight/33.4);
    [_forgotBtn setBackgroundImage:[UIImage imageNamed:@"Login_forgot"] forState:UIControlStateNormal];
    [self addSubview:_forgotBtn];
    
    //分割线2
    UIImageView * imageLine2=[[UIImageView alloc]init];
    imageLine2.frame=CGRectMake(imageLine1.frame.origin.x, KviewHeight/1.64, _passwordText.frame.size.width+17, 1);
    imageLine2.image=[UIImage imageNamed:@"Login_line"];
    [self addSubview:imageLine2];
    
    //登陆btn
    _loginbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginbtn.frame=CGRectMake(KviewWidth/10.7, KviewHeight/1.54, KviewWidth/1.23, KviewHeight/13.2);
    [_loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    UIColor * color=KcolorRGB(234, 80, 62);
    [_loginbtn setBackgroundColor:color];
    _loginbtn.alpha=0.8;
    //[_loginbtn setBackgroundImage:[UIImage imageNamed:@"Login_登陆"] forState:UIControlStateNormal];
    [self addSubview:_loginbtn];
    
    //找回密码btn
    _backPasswordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _backPasswordBtn.frame=CGRectMake(_loginbtn.frame.origin.x, KviewHeight/1.34, _loginbtn.frame.size.width/3.5, KviewHeight/14.2);
    [_backPasswordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    UIColor * color1 = [UIColor colorWithRed:(0/255.0f) green:( 0/255.0f)blue:(0/255.0f) alpha:1.0f];
    [_backPasswordBtn setTitleColor:color1 forState:UIControlStateNormal];
    _backPasswordBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    _backPasswordBtn.alpha=0.5;
    [self addSubview:_backPasswordBtn];
    
    //注册登录btn
    _registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame=CGRectMake(CGRectGetMaxX(_backPasswordBtn.frame)+KviewWidth/2.91, _backPasswordBtn.frame.origin.y , _loginbtn.frame.size.width/3.5, _backPasswordBtn.frame.size.height);
    [_registBtn setTitle:@"注册登录" forState:UIControlStateNormal];
    _registBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    UIColor * color2 = [UIColor colorWithRed:(0/255.0f) green:( 0/255.0f)blue:(0/255.0f) alpha:1.0f];
    [_registBtn setTitleColor:color2 forState:UIControlStateNormal];
    _registBtn.alpha=0.5;
    [self addSubview:_registBtn];
    
    //协议icon
//    UIImageView * protocolIcon=[[UIImageView alloc]init];
//    protocolIcon.frame=CGRectMake(KviewWidth/4, KviewHeight/1.136, KviewWidth/2.13, KviewHeight/43.7);
//    protocolIcon.image=[UIImage imageNamed:@"Login_用户协议"];
//    [self addSubview:protocolIcon];
    
}


@end
