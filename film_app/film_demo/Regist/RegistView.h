//
//  RegistView.h
//  clouclip
//
//  Created by rejoin on 15/9/21.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKCountDownButton.h"

@interface RegistView : UIView

@property (strong,nonatomic)UITextField * phoneNumberText; //用户名text
@property (strong,nonatomic)UITextField * verificationText; //验证码text
@property (strong,nonatomic)UITextField * passwordText; //密码text
@property (strong,nonatomic)UITextField * passwordText1; //验证密码text

@property (strong,nonatomic)UIButton * registbtn; //注册btn
@property (strong,nonatomic)UIButton * haveBtn; //已有账号btn
@property (strong,nonatomic)UIButton * backBtn; //返回btn

@property (strong,nonatomic)JKCountDownButton * countDownCode; //倒计时btn



@end
