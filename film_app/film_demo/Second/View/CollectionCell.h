//
//  CollectionCell.h
//  film_demo
//
//  Created by rejoin on 15/5/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IMAGE_HEIGHT 150
#define IMAGE_OFFSET_SPEED 25

@interface CollectionCell : UICollectionViewCell

/*
 
 image used in the cell which will be having the parallax effect
 
 */
@property (nonatomic, strong, readwrite) UIImage *image;

/*
 Image will always animate according to the imageOffset provided. Higher the value means higher offset for the image
 */
@property (nonatomic, assign, readwrite) CGPoint imageOffset;


@end
