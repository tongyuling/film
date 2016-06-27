//
//  DIImageView.m
//  DIImageView
//
//  Created by Daniel Inoa Llenas on 8/18/14.
//  Copyright (c) 2014 Daniel Inoa Llenas. All rights reserved.
//

#import "DIImageView.h"
#import "Common.h"

@implementation DIImageView

@synthesize caption;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initCaption];

        // Tap Gesture for ImageView
        UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped)];
        imageViewTap.delegate = self;
        [self addGestureRecognizer:imageViewTap];
        [self setUserInteractionEnabled:YES];
        
        // Drag Gesture for Caption
//        UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(captionDrag:)];
//        [self addGestureRecognizer:drag];
        
        UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panpan:)];
        [self.caption addGestureRecognizer:panGesture];
        self.frame1 = self.caption.frame;
        
    }
    return self;
}


- (void)panpan:(UIPanGestureRecognizer *)sender {
    
    DIImageView * view1=[[DIImageView alloc]init];
    [view1 bringSubviewToFront:self.caption];
    CGPoint location = [sender locationInView:view1];
    sender.view.center = CGPointMake(location.x,  location.y);
}



- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    // Caption
    [self initCaption];
}

- (void) initCaption{

//    caption = [[UITextField alloc] initWithFrame:CGRectMake(0,self.frame.size.height/2,self.frame.size.width,40)];
//    caption.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    caption.textAlignment = NSTextAlignmentCenter;
//    caption.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    caption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    caption.textColor = [UIColor whiteColor];
//    caption.keyboardAppearance = UIKeyboardAppearanceDark;
//    caption.alpha = 0;
//    caption.tintColor = [UIColor whiteColor];
//    caption.delegate = self;
//    [self addSubview:caption];
    
    caption=[[UITextView alloc]initWithFrame:CGRectMake(self.frame.size.width/9, self.frame.size.height/3, self.frame.size.width/1.25, self.frame.size.height/4)];
    caption.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    caption.textAlignment = NSTextAlignmentCenter;
    caption.textColor = [UIColor whiteColor];
    caption.keyboardAppearance = UIKeyboardAppearanceDark;
    caption.alpha = 0;
    caption.font=[UIFont systemFontOfSize:16];
    caption.tintColor = [UIColor whiteColor];
    caption.delegate = self;
    [self.viewForBaselineLayout addSubview:caption];
}

- (void) imageViewTapped{
    
//    caption.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    caption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if([caption isFirstResponder]){
        //[caption resignFirstResponder];
        caption.alpha = ([caption.text isEqualToString:@""]) ? 0 : caption.alpha;
    } else {
        [caption becomeFirstResponder];
        caption.alpha = 1;
    }
}



#pragma mark 拖动
- (void) captionDrag: (UIGestureRecognizer*)gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer locationInView:self];

    if(translation.y < caption.frame.size.height/2){
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  caption.frame.size.height/2);
    } else if(self.frame.size.height < translation.y + caption.frame.size.height/2){
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  self.frame.size.height - caption.frame.size.height/2);
    } else {
        caption.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,  translation.y);
    }
    
}

//- (BOOL)textField:(UITextField *)textField
//shouldChangeCharactersInRange:(NSRange)range
//replacementString:(NSString *)string{
//    
//    self.text = [self.text stringByReplacingCharactersInRange:range withString:string];
//    CGSize textSize = [self.text sizeWithAttributes: @{NSFontAttributeName:textField.font}];
//    
//    return (textSize.width + 10 < textField.bounds.size.width) ? true : false;
//}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        caption.backgroundColor = [UIColor clearColor];
        self.text = textView.text;
        NSLog(@"self.text==%@",self.text);
        return NO;
    }
    
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [caption resignFirstResponder];
    return YES;
}



@end


