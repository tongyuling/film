//
//  LoginView.h
//  clouclip
//
//  Created by rejoin on 15/9/21.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (strong,nonatomic)UITextField * phoneNumberText; //账号text
@property (strong,nonatomic)UITextField * passwordText; //密码text

@property (strong,nonatomic)UIButton * forgotBtn; //问号btn
@property (strong,nonatomic)UIButton * loginbtn; //登陆btn
@property (strong,nonatomic)UIButton * registBtn; //注册btn
@property (strong,nonatomic)UIButton * backPasswordBtn; //找回密码btn

@end
