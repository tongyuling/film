//
//  RegistController.m
//  clouclip
//
//  Created by rejoin on 15/7/30.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "RegistController.h"
#import "Common.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+ble.h"
#import "User.h"
#import "UserTool.h"
#import "MMProgressHUD.h"
#import "LoginTool.h"
#import "RegistTool.h"
#import "FirstController.h"
#import "JKCountDownButton.h"
#import "RegistView.h"

@interface RegistController ()<UITextFieldDelegate>

@property (strong,nonatomic)RegistView * registView;

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self buildUI];
}


-(void)buildUI
{
    __block RegistController * weakSelf = self;
    
    //创建view
    self.registView=[[RegistView alloc]initWithFrame:CGRectMake(0, 0, KviewWidth, KviewHeight)];
    [self.view addSubview:self.registView];
    
    //设置delegate
    self.registView.phoneNumberText.delegate=self;
    self.registView.verificationText.delegate=self;
    self.registView.passwordText.delegate=self;
    self.registView.passwordText1.delegate=self;
    //btn
    [self.registView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.registView.registbtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [self.registView.haveBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registView.countDownCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        [sender startWithSecond:60];
        
        [weakSelf alert];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            
            NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新获取验证码";
            
        }];
        
    }];
}

-(void)alert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请直接填写密码" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


#pragma mark 注册btn
-(void)regist
{
    if ([self.registView.phoneNumberText.text isEmptyString] || [self.registView.passwordText.text isEmptyString] || [self.registView.passwordText1.text isEmptyString]) {
        [self showAlert:@"注册信息填写不完整！"];
        return;
    }
    if (![self.registView.passwordText.text isEqualToString:self.registView.passwordText1.text]) {
        [self showAlert:@"密码输入不一致！"];
        return;
    }
    if (self.registView.passwordText.text.length<6 || self.registView.passwordText.text.length>12) {
        [self showAlert:@"请输入6-12位密码"];
        return;
    }
    if (![self validatePhone2:self.registView.phoneNumberText.text]) {
        [self showAlert:@"请输入正确的手机号！"];
        return;
    }
    
    // 1.菊花转动
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"提示" status:@"正在注册..."];
    
    //2,准备参数
    NSString * phoneNumber=[self.registView.phoneNumberText.text trimString];
    NSString * password=[self.registView.passwordText.text trimString];
    
    //md5转码后的字符串
    NSString * str=[self getMd5_32Bit_String:password];
    
    MyLog(@"账号：%@ 密码：%@",phoneNumber,str);
    
    //3.请求
    [RegistTool registWithPhoneNumber:phoneNumber password:str SUCCESS:^(id responseObject){
        NSString * success=responseObject[@"ret"];
        int suc=[success intValue];
        
        if (suc==0) {
            // 注册成功，登陆
            [LoginTool loginWithPhoneNumber:phoneNumber password:str SUCCESS:^(id responseObject) {
                NSString * success=responseObject[@"ret"];
                int suc=[success intValue];
                
                if (suc==0) {
                    
                    NSString * str=responseObject[@"data"][@"token"];
                    //保存数据
                    User * user=[[User alloc]initWithPhoneN:phoneNumber password:password token:str];
                    
                    [[UserTool sharedUserTool]saveUser:user];
                    
                    double delayInSecond = 1.0;
                    dispatch_time_t popTimes = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSecond * NSEC_PER_SEC));
                    dispatch_after(popTimes, dispatch_get_main_queue(), ^(void){
                        
                        // 菊花停止
                        [MMProgressHUD dismissWithSuccess:@"注册成功！" title:@"成功"];
                        
                        FirstController * first=[[FirstController alloc]init];
                        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:first];
                        [self presentViewController:nav animated:YES completion:nil];
                    });
                }
                else{
                    [MMProgressHUD dismissWithError:@"注册失败！" title:@"失败"];
                }
                
            } DBERROR:^(NSError *error) {
                MyLog(@"请求注册失败！error:%@", error.localizedDescription);
                // 菊花停止
                [MMProgressHUD dismissWithError:@"请求注册失败！" title:@"失败"];
            }];
            
        }
        else{
            [MMProgressHUD dismissWithError:@"注册失败！" title:@"失败"];
        }
        
    } DBERROR:^(NSError *error) {
        MyLog(@"请求注册失败！error:%@", error.localizedDescription);
        // 菊花停止
        [MMProgressHUD dismissWithError:@"请求注册失败！" title:@"失败"];
    }];
    
}



#pragma mark 返回btn
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 警告框
-(void)showAlert:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


#pragma mark 32位MD5加密方式
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char * cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}


#pragma mark 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //将视图恢复到原始状态
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view endEditing:YES];
}


#pragma mark UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==self.registView.passwordText) {
        [self.registView.passwordText1 becomeFirstResponder];
    }
    if (textField==self.registView.passwordText1) {
        
        //将视图恢复到原始状态
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        // 当前焦点在密码文本框
        // 登陆
        //[self registBtn];
        [textField resignFirstResponder];
    }
    
    return YES;
}


#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (iPhone4) {
        if (textField==self.registView.phoneNumberText) {
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 229 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0){
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }
            [UIView commitAnimations];
        }
        if (textField==self.registView.verificationText) {
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 175 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0){
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }
            [UIView commitAnimations];
        }
        if (textField==self.registView.passwordText) {
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 113 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0){
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }
            [UIView commitAnimations];
        }
        if (textField==self.registView.passwordText1) {
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 50 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0){
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }
            [UIView commitAnimations];
        }
    }
}


#pragma mark 验证手机号方法
//正则判断手机号码格式
- (BOOL)validatePhone2:(NSString *)phone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            MyLog(@"China Mobile");
            
        } else if([regextestct evaluateWithObject:phone] == YES) {
            MyLog(@"China Telecom");
            
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            MyLog(@"China Unicom");
            
        } else {
            MyLog(@"Unknow");
        }
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
