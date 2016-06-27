//
//  CollectionCell.m
//  film_demo
//
//  Created by rejoin on 15/5/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "CollectionCell.h"
#import "Common.h"

@interface CollectionCell()

@property (nonatomic, strong, readwrite) UIImageView * ImageView;

@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setupImageView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self setupImageView];
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Setup Method
- (void)setupImageView
{
    // Clip subviews
    self.clipsToBounds = YES;
    
    // Add image subview
    self.ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, KviewWidth, IMAGE_HEIGHT)];
    self.ImageView.backgroundColor = [UIColor redColor];
    self.ImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.ImageView.clipsToBounds = NO;
    [self addSubview:self.ImageView];
}

# pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    // Store image
    self.ImageView.image = image;
    
    // Update padding
    [self setImageOffset:self.imageOffset];
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    // Store padding value
    _imageOffset = imageOffset;
    
    // Grow image view
    CGRect frame = self.ImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    self.ImageView.frame = offsetFrame;
}



@end
