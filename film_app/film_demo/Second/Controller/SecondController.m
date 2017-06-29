//
//  SecondController.m
//  aLittleTool
//
//  Created by rejoin on 15/4/23.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "SecondController.h"
#import "Common.h"
#import "UIImage+text.h"

@interface SecondController ()<UIGestureRecognizerDelegate,UITextViewDelegate>


@property (nonatomic,strong)UIImageView * imageView;//imageview
@property (nonatomic,strong)UITextView *caption;//textview

@property (nonatomic,strong)UIImage * lastImage;//最后的文字和图片
@property (nonatomic,copy)NSString * text;//textview最后的文字

@property CGRect frame1;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=KcolorRGB(234, 80, 62);
    
    UIView * view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, KviewWidth, 64);
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    //添加控件
    [self buildUI];
}


#pragma mark 添加控件
-(void)buildUI
{
    // 添加左导航栏按钮
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIColor * color=KcolorRGB(234, 80, 62);
    [leftBtn setTintColor:color];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // 添加右导航栏按钮
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baoCunBtn)];
    [rightBtn setTintColor:color];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    // 添加装图片的imageview
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 70, KviewWidth-20, KviewHeight-84)];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.selectImage]]];
    [self.view addSubview:imageView];
    self.imageView=imageView;
    
    // 添加textview
    self.caption=[[UITextView alloc]initWithFrame:CGRectMake(KviewWidth/14, KviewHeight/6, KviewWidth/1.25, KviewHeight/4)];
    self.caption.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.caption.textAlignment = NSTextAlignmentCenter;
    self.caption.textColor = [UIColor whiteColor];
    self.caption.keyboardAppearance = UIKeyboardAppearanceDark;
    self.caption.alpha = 0;
    self.caption.font=[UIFont systemFontOfSize:16];
    self.caption.tintColor = [UIColor whiteColor];
    self.caption.delegate = self;
    [self.imageView addSubview:self.caption];
    
    
    // 给ImageView添加手势
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    imageViewTap.delegate = self;
    [imageView addGestureRecognizer:imageViewTap];
    [imageView setUserInteractionEnabled:YES];
    
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.caption addGestureRecognizer:panGesture];
    
    
}


#pragma mark 保存方法
-(void)baoCunBtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //判断是否是retina屏
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
            
            // 开启图像上下文
            
            UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
            
        } else {
            
            // 开启图像上下文
            
            UIGraphicsBeginImageContext(self.view.window.bounds.size);
            
        }
        
        
        // 将当前视图图层渲染到当前上下文
        
        [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        // 从当前上下文获取图像
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭图像上下文
        
        UIGraphicsEndImageContext();
        
        // 保存图片到相册
        
        //
        UIImage * img = [self imageAddText:self.imageView.image text:self.caption.text];
        
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

#pragma mark 图片+文字
- (UIImage *)imageAddText:(UIImage *)img text:(NSString *)logoText
{
    NSString* mark = logoText;
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:50], NSForegroundColorAttributeName : [UIColor whiteColor]  };
    //位置显示
    [mark drawInRect:self.frame1 withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return aimg;
    
}

/************************/
#pragma mark 手势方法
#pragma mark 点击
- (void) tap
{
    if([self.caption isFirstResponder]){
        //[self.caption resignFirstResponder];
        //self.caption.alpha = ([self.caption.text isEqualToString:@""]) ? 0 : self.caption.alpha;
        self.caption.alpha=1;
    } else {
        [self.caption becomeFirstResponder];
        self.caption.alpha = 1;
    }
}

#pragma mark 拖动
- (void)pan:(UIPanGestureRecognizer *)sender
{
    [self.imageView bringSubviewToFront:self.caption];
    CGPoint location = [sender locationInView:self.imageView];
    sender.view.center = CGPointMake(location.x,  location.y+50);
    
    
//    NSLog(@"x==%f",self.caption.frame.origin.x);
//    NSLog(@"y==%f",self.caption.frame.origin.y);
//    NSLog(@"width==%f",self.caption.frame.size.width);
//    NSLog(@"height==%f",self.caption.frame.size.height);
    
    self.frame1=CGRectMake(self.caption.frame.origin.x, self.caption.frame.origin.y, self.caption.frame.size.width, self.caption.frame.size.height);
    
    NSLog(@"frame1==%@",NSStringFromCGRect(self.frame1));
}
/************************/



#pragma mark 上下拖动
- (void) captionDrag: (UIGestureRecognizer*)gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer locationInView:self.imageView];
    
    if(translation.y < self.caption.frame.size.height/2){
        self.caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  self.caption.frame.size.height/2);
    } else if(KviewHeight < translation.y + self.caption.frame.size.height/2){
        self.caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  KviewHeight - self.caption.frame.size.height/2);
    } else {
        self.caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  translation.y);
    }
}

#pragma mark textview delegate 收起键盘

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        self.caption.backgroundColor = [UIColor clearColor];
        
        self.text = textView.text;
        
        return NO;
    }

    return YES;
}

//开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.caption.backgroundColor=KColorFromRGB(0x808069);
    return self.caption;
}

#pragma mark 返回按钮方法
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
