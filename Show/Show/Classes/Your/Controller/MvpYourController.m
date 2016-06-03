//
//  MvpYourController.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpYourController.h"
#import "MvpResultTableViewController.h"



@interface MvpYourController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property(nonatomic,strong)NSMutableArray *dataList;

@property(nonatomic,strong)UISearchController *searchController;

@property(nonatomic,strong)MvpResultTableViewController *resultTableView;

@end

@implementation MvpYourController

-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建展示tableView
    self.resultTableView = [[MvpResultTableViewController alloc]init];
    //初始化search控制器
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.resultTableView];
    self.searchController.searchBar.placeholder = @"请输入车辆查询条件";
    
//    for (UIView *view in self.searchController.searchBar.subviews) {
//        // for before iOS7.0
//        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            [view removeFromSuperview];
//            break;
//        }
//        // for later iOS7.0(include)
//        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
//            [[view.subviews objectAtIndex:0] removeFromSuperview];
//            break;
//        }
//    }

    self.tableView.tableHeaderView = self.searchController.searchBar;
//    self.navigationItem.titleView = self.searchController.searchBar;
    //设置代理
    self.searchController.searchResultsUpdater = self;
    for(int i = 0; i < 55; i++){
        [self.dataList addObject:[NSString stringWithFormat:@"%d - car - $ %d 万元",i+1,i+1]];
    }
    
}

//更新搜索结果
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",self.searchController.searchBar.text];
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    //传值
    self.resultTableView.resultList = resultArray;
    //刷新
    [self.resultTableView.tableView reloadData];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cellOne";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

#pragma mark SearchBar

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)
//searchText{
//    //监听长度
//    NSLog(@"%@",searchText);
//}
//
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBa{
//    
//    NSLog(@"点击输入框激活的方法");
//    
//    self.tabBarController.tabBar.hidden = YES;
//    
//    return YES;
//}
//
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    
//    [searchBar resignFirstResponder];
//    
//    NSLog(@"点了我");
//}

@end
