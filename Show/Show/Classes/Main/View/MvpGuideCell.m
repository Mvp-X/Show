//
//  MvpGuideCell.m
//  Show
//
//  Created by Colorful on 16/5/23.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpGuideCell.h"
#import "MvpMainTabBarController.h"

@interface MvpGuideCell()

@property (nonatomic,weak) UIImageView* imageView;


@end


@implementation MvpGuideCell

- (UIImageView*)imageView
{
    if (_imageView == nil) {
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.frame = [UIScreen mainScreen].bounds;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)setImage:(UIImage*)image
{
    _image = image;
    
    // 把数据放到空间上
    self.imageView.image = image;
}



@end
