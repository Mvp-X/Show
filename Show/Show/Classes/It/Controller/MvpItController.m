//
//  MvpItController.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpItController.h"

@interface MvpItController ()

@end

@implementation MvpItController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(PushMore)];
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
//--------此处填写加载数据--------
    

}

-(void)PushMore{

    [self presentViewController:[[UIStoryboard storyboardWithName:@"More" bundle:nil]instantiateInitialViewController] animated:NO completion:nil];

}

@end
