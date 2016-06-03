//
//  MvpLiveController.m
//  Show
//
//  Created by Colorful on 16/5/28.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpLiveController.h"

@interface MvpLiveController ()

@end

@implementation MvpLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

// cell点击事件
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 第一个cell不弹
    if (indexPath.section == 0) {
        return;
    }
    // 创建一个看不到的textField
    UITextField* text = [[UITextField alloc] init];
    
    // 获取cell
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 添加到cell中
    [cell.contentView addSubview:text];
    
    // 创建datePicker
    UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    // 中文
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    // 样式-时分
    datePicker.datePickerMode = UIDatePickerModeTime;
    
    // 给全局属性赋值
    self.datePicker = datePicker;
    
    // 修改 inputView
    text.inputView = datePicker;
    
    // 创建toolbar
    UIToolbar* bar = [[UIToolbar alloc] init];
    
    // 修改高度
    bar.h = 44;
    
    // 创建toolbar上三个按钮
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneClcik)];
    
    // 设置按钮
    bar.items = @[ cancelItem, item, doneItem ];
    
    // 设置辅助视图
    text.inputAccessoryView = bar;
    
    // 成为第一响应者
    [text becomeFirstResponder];
}

// 取消按钮
- (void)cancelClick
{
    [self.view endEditing:YES];
}

// 完成按钮
- (void)doneClcik
{
    
    // 获取时间
    NSDate* date = self.datePicker.date;
    
    // 创建格式化时间的对象
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    // 设置格式化的样式
    formatter.dateFormat = @"HH:mm";
    
    // 把date转成string
    NSString* time = [formatter stringFromDate:date];
    
    // 获取indexpath
    NSIndexPath* path = [self.tableView indexPathForSelectedRow];
    
    // 获取cell
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:path];
    
    // 设置时间
    cell.detailTextLabel.text = time;
    
    // 收键盘
    [self cancelClick];
}


@end
