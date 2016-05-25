//
//  MvpMoreCell.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpMoreCell.h"
#import "MvpArticleTabController.h"

@interface MvpMoreCell()

@property (nonatomic,strong)MvpArticleTabController *ArticleVC;


@end


@implementation MvpMoreCell

//创建时调用-为重用实现
- (void)awakeFromNib{
    
    //1.加载NewsStoryBoard
    UIStoryboard *newsStoryBoard = [UIStoryboard storyboardWithName:@"Article" bundle:nil];
    
    //2.去加载NewsStoryBoard的初始化控制器
    self.ArticleVC = newsStoryBoard.instantiateInitialViewController;
    
    //3.设置添加上去的newsTableVc的根视图的大小
    self.ArticleVC.tableView.frame = self.contentView.bounds;
    
//    self.ArticleVC.tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    //添加到item.contentView
    [self.contentView addSubview:self.ArticleVC.tableView];
}
//传给控制器
-(void)setURLString:(NSString *)URLString{
    
    self.ArticleVC.vcURLString = URLString;
}

@end
