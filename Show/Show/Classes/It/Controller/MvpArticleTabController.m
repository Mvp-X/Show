//
//  MvpArticleTabController.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpArticleTabController.h"
#import "MvpNews.h"
#import "MvpNewsCell.h"



@interface MvpArticleTabController ()

@property(nonatomic,strong)NSArray *innerNewsList;

@end

@implementation MvpArticleTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消弹簧
    self.tableView.bounces = NO;
}

-(void)setVcURLString:(NSString *)vcURLString{
    _vcURLString = vcURLString;
    __weak typeof(self) weakSelf = self;
    [MvpNews newsListWithURLString:vcURLString finishedBlock:^(NSArray *newsList) {
        //1.记录数据
        weakSelf.innerNewsList = newsList;
        
        //2.刷新表格
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.innerNewsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    
    MvpNews *currentNews = self.innerNewsList[indexPath.row];
    
    if (currentNews.imgType) {//大图
        identifier = @"BigCell";
    }else if(currentNews.imgextra.count==2){//三张图
        identifier = @"ThreeCell";
    }else{
        identifier = @"BaseCell";
    }
    
    MvpNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.news = currentNews;
    
    return cell;
}

#pragma mark - UITableViewDelegate 返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MvpNews *currentNews = self.innerNewsList[indexPath.row];
    
    if (currentNews.imgType) {//大图
        return 200;
    }else if(currentNews.imgextra.count==2){
        return 120;
    }else{
        return 80;
    }
}
@end
