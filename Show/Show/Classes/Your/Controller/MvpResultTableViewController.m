//
//  MvpResultTableViewController.m
//  Show
//
//  Created by Colorful on 16/6/2.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpResultTableViewController.h"


@interface MvpResultTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MvpResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellTwo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.resultList[indexPath.row];
    
    return cell;
}

@end
