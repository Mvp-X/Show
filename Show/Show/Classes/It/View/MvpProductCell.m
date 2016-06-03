//
//  MvpProductCell.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpProductCell.h"

@interface MvpProductCell()

@property (weak, nonatomic) IBOutlet UIImageView* iconView;
@property (weak, nonatomic) IBOutlet UILabel* titleView;

@end

@implementation MvpProductCell

- (void)setProduct:(MvpProduct*)product
{
    _product = product;
    
    // 处理imageView圆角
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;
    
    // 把数据放在控件上
    self.iconView.image = [UIImage imageNamed:product.icon];
    self.titleView.text = product.title;
}


@end
