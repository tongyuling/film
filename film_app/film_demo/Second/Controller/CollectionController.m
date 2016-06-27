//
//  CollectionController.m
//  film_demo
//
//  Created by rejoin on 15/5/29.
//  Copyright (c) 2015年 rejoin. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionCell.h"
#import "Common.h"
#import "SecondController.h"

@interface CollectionController () <UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *parallaxCollectionView;

@property (nonatomic, strong) NSMutableArray * images;

@property (strong,nonatomic) UIImage * selectImage;

@end

@implementation CollectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Fill image array with images
    NSUInteger index;
    for (index = 0; index < 14; ++index) {
        // Setup image name
        NSString *name = [NSString stringWithFormat:@"image%ld.jpg", (unsigned long)index];
        if(!self.images)
            self.images = [NSMutableArray arrayWithCapacity:0];
        [self.images addObject:name];
    }
    
    [self.parallaxCollectionView reloadData];
    
    UIView * view1=[[UIView alloc]init];
    view1.frame=CGRectMake(0, 0, KviewWidth, 64);
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    
    //添加左导航栏按钮
    UIBarButtonItem * leftBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIColor * color=KcolorRGB(234, 80, 62);
    [leftBtn setTintColor:color];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

#pragma mark - UICollectionViewDatasource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //get image name and assign
    NSString* imageName = [self.images objectAtIndex:indexPath.item];
    cell.image = [UIImage imageNamed:imageName];
    
    //set offset accordingly
    CGFloat yOffset = ((self.parallaxCollectionView.contentOffset.y - cell.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
    cell.imageOffset = CGPointMake(0.0f, yOffset+30);
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectImage=self.images[indexPath.row];
    NSLog(@"selectImage==%@",self.selectImage);

    SecondController * second=[[SecondController alloc]init];
    second.selectImage=self.selectImage;
    [self.navigationController pushViewController:second animated:YES];
}


#pragma mark - UIScrollViewdelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(CollectionCell *view in self.parallaxCollectionView.visibleCells) {
        CGFloat yOffset = ((self.parallaxCollectionView.contentOffset.y - view.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
        view.imageOffset = CGPointMake(0.0f, yOffset+40);
    }
}


//是否显示 copy、cut、paste等
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//是否显示action辅助功能
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    SEL sel=@selector(copy:);
    if (sel==action) {
        return YES;
    }
    return NO;
}
//判断选择的是什么action
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    SEL sel=@selector(copy:);
    if (sel==action) {
        NSLog(@"aaaaa");
    }
}



-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
