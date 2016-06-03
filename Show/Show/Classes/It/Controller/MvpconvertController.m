//
//  MvpconvertController.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpconvertController.h"

@interface MvpconvertController ()

@end

@implementation MvpconvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setSegmentedControl];
}


-(void)setSegmentedControl{

    // 设置控制器view的背景图片
//    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"NLArenaBackground"].CGImage;
    
    // 创建UISegmentedControl
    UISegmentedControl * seg=[[UISegmentedControl alloc] initWithFrame:CGRectMake(80.0f, 8.0f, 150.0f, 30.0f) ];
    //设置标题
    [seg insertSegmentWithTitle:@"One" atIndex:0 animated:YES];
    [seg insertSegmentWithTitle:@"Two" atIndex:1 animated:YES];
    [seg insertSegmentWithTitle:@"Three" atIndex:2 animated:YES];
    
    // 设置seg的背景--UIBarMetricsDefault会完整填充
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [seg setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    //是否保持选中状态
    seg.momentary = YES;
    //关闭多点触摸
    seg.multipleTouchEnabled=NO;
    
    // 设置文字的颜色
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];
    
    // 取消蓝色的线
    [seg setTintColor:[UIColor clearColor]];
    
    //添加切换方法
//    [seg addTarget:self action:@selector(SelectSeg) forControlEvents:UIControlEventValueChanged];
    
    //设置替换titleView
    [self.navigationItem setTitleView:seg];
    

}
@end
