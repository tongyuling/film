//
//  DIImageView.h
//  DIImageView
//
//  Created by Daniel Inoa Llenas on 8/18/14.
//  Copyright (c) 2014 Daniel Inoa Llenas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIImageView : UIImageView <UIGestureRecognizerDelegate,UITextViewDelegate>

@property UITextView *caption;
@property (assign, nonatomic) CGPoint beginpoint;
@property CGRect frame1;
@property CGFloat lastRotation;

@property (nonatomic,strong)UIImage * lastImage;

@property (nonatomic,copy)NSString * text;

@end


