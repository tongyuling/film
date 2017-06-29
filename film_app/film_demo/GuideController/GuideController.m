//
//  GuideController.m
//  ble4.0
//
//  Created by rejoin on 15/5/12.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "GuideController.h"
#import "UIImage+ble.h"
#import "LoginController.h"
#import "Common.h"

@interface GuideController ()<UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView *_scroll;
}
@end

@implementation GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor blackColor];
    
    [self addScrollView];
    [self addScrollImage];
    
}

#pragma mark 添加滚动视图
- (void)addScrollView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    CGSize size = scroll.frame.size;
    scroll.contentSize = CGSizeMake(3 * size.width, 0);
    scroll.pagingEnabled = YES;//滑动分页
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.delegate = self;//设置委托
    [self.view addSubview:scroll];
    _scroll = scroll;
}

#pragma mark 添加滚动视图图片
- (void)addScrollImage
{
    CGSize size = self.view.bounds.size;
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * size.width, 0, size.width, size.height)];
        imageView.userInteractionEnabled = YES;
        //添加三张图片
        UIImage *image = [UIImage fullScreenImage:[NSString stringWithFormat:@"Guide_img_%d", i + 1]];
        imageView.image = image;
        [_scroll addSubview:imageView];
        //最后一页
        if (i == 2)
        {

            UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(KviewWidth/3.2, KviewHeight/1.15, KviewWidth/2.5, KviewHeight/15);
            [btn setBackgroundImage:[UIImage imageNamed:@"Guide_button"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
            
        }
    }
}

#pragma mark 点击进入主视图
-(void)start:(UIButton *)sender
{
    
    LoginController *Login = [LoginController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Login];
    self.view.window.rootViewController = nav;

}


@end
