//
//  MvpAboutController.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpAboutController.h"
#import "MvpAbout.h"

@interface MvpAboutController ()

@end

@implementation MvpAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建头部的view
    MvpAbout* aboutView = [MvpAbout aboutHeaderView];
    // 设置头部的view
    self.tableView.tableHeaderView = aboutView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
