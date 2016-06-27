//
//  LoginController.m
//  ble
//
//  Created by rejoin on 15/7/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "LoginController.h"
#import "Common.h"
#import "User.h"
#import "UserTool.h"
#import "NSString+ble.h"
#import "MMProgressHUD.h"
#import "LoginTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegistController.h"
#import "FirstController.h"
#import "LoginView.h"

@interface LoginController ()<UITextFieldDelegate>

@property (strong,nonatomic)LoginView * loginView;
@property (nonatomic)BOOL isSecret; //是否密码形式

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self buildUI];
    
    // 初始化文本框中的内容
    if ([UserTool sharedUserTool].user) {
        self.loginView.phoneNumberText.text = [UserTool sharedUserTool].user.phoneNumber;
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
}


-(void)buildUI
{
    //创建view
    self.loginView=[[LoginView alloc]initWithFrame:CGRectMake(0, 0, KviewWidth, KviewHeight)];
    [self.view addSubview:self.loginView];
    
    self.isSecret=YES;
    //设置delegate
    self.loginView.phoneNumberText.delegate=self;
    self.loginView.passwordText.delegate=self;
    
    //btn方法
    [self.loginView.forgotBtn addTarget:self action:@selector(forgotBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.loginbtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.backPasswordBtn addTarget:self action:@selector(backPasswordBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.registBtn addTarget:self action:@selector(registBtn) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 登录方法
-(void)loginBtn
{
    // 获取用户名
    NSString * phoneNumber = [self.loginView.phoneNumberText.text trimString];
    // 获取密码
    NSString * password = self.loginView.passwordText.text;
    NSString * str=[self getMd5_32Bit_String:password];
    
    MyLog(@"login.userid=%@ login.str=%@",phoneNumber,str);
    
    if ([phoneNumber isEmptyString] || [self.loginView.passwordText.text isEmptyString]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"内容填写不完整！" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        return;
    }
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"提示" status:@"正在登陆..."];
    
    [LoginTool loginWithPhoneNumber:phoneNumber password:str SUCCESS:^(id responseObject) {
        NSString * success=responseObject[@"status"];
        int suc=[success intValue];
        MyLog(@"suc-%d",suc);
        
        if (suc==0) {
            
            
            NSString * token=responseObject[@"data"][@"token"];
            
            //保存数据
            User * user=[[User alloc]initWithPhoneN:phoneNumber password:password token:token];
            [[UserTool sharedUserTool]saveUser:user];
            
            
            //菊花停止
            [MMProgressHUD dismissWithSuccess:@"登陆成功！" title:@"成功"];
            
            FirstController * first=[[FirstController alloc]init];
            UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:first];
            [self presentViewController:nav animated:YES completion:nil];  
        }
        else
        {
            [MMProgressHUD dismissWithError:responseObject[@"message"] title:@"失败"];
        }

    } DBERROR:^(NSError *error) {
        //菊花停止
        [MMProgressHUD dismissWithError:@"请求登陆失败！" title:@"失败"];
        MyLog(@"请求登陆失败！error=%@",error.localizedDescription);
    }];

}



#pragma mark password显示密码样式
-(void)forgotBtn
{
    if (self.isSecret==YES) {
        [self.loginView.passwordText setSecureTextEntry:NO];
        
        self.isSecret=NO;
    }
    else{
        [self.loginView.passwordText setSecureTextEntry:YES];
        self.isSecret=YES;
    }
    
}


#pragma mark 找回密码方法
-(void)backPasswordBtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"尽请期待" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


#pragma mark 立即注册按钮
-(void)registBtn
{
    RegistController * regist=[[RegistController alloc]init];
    [self presentViewController:regist animated:YES completion:nil];
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


#pragma mark textfield收起键盘方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (iPhone4) {
        if (textField==self.loginView.phoneNumberText) {
            
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 70 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            
            [UIView commitAnimations];
        }
        if (textField==self.loginView.passwordText) {
            
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 80 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            
            [UIView commitAnimations];
        }
    }
    if (iPhone5) {
        if (textField==self.loginView.phoneNumberText) {
            
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 75 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            
            [UIView commitAnimations];
        }
        if (textField==self.loginView.passwordText) {
            
            CGRect frame = textField.frame;
            int offset = frame.origin.y + 95 - (self.view.frame.size.height - 216.0);//键盘高度216
            
            NSTimeInterval animationDuration = 0.30f;
            [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
            [UIView setAnimationDuration:animationDuration];
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            if(offset > 0)
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            
            [UIView commitAnimations];
        }
    }
    
}


#pragma mark UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.loginView.passwordText) { // 当前焦点在密码文本框
        //将视图恢复到原始状态
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //收起键盘
        [textField resignFirstResponder];
    }
    return YES;
}


@end
