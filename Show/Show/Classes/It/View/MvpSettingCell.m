//
//  MvpSettingCell.m
//  Show
//
//  Created by Colorful on 16/5/26.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpSettingCell.h"

@implementation MvpSettingCell

+ (instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary*)item
{
    // id
    NSString* cellid = @"";
    // 解决cell重用问题 - 让每一类型的cell都有唯一的一个标示符
    if (item[@"cellType"] && [item[@"cellType"] length] > 0) {
        cellid = item[@"cellType"];
    }
    else {
        cellid = @"UITableViewCellStyleDefault";
    }
    
    // 缓存池
    MvpSettingCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    // 如果缓存池没有找到
    if (cell == nil) {
        // 创建cell
        cell = [[MvpSettingCell alloc] initWithStyle:[self loadCellTypeWithItem:item] reuseIdentifier:cellid];
    }
    return cell;
}

// 根据item返回应该创建的cell的类型
+ (UITableViewCellStyle)loadCellTypeWithItem:(NSDictionary*)item
{
    NSString* cellType = item[@"cellType"];
    
    if ([cellType isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        return UITableViewCellStyleSubtitle;
    }
    else if ([cellType isEqualToString:@"UITableViewCellStyleValue1"]) {
        return UITableViewCellStyleValue1;
    }
    else if ([cellType isEqualToString:@"UITableViewCellStyleValue2"]) {
        return UITableViewCellStyleValue2;
    }
    else {
        return UITableViewCellStyleDefault;
    }
}

- (void)setItem:(NSDictionary*)item
{
    _item = item;
    // 把数据放在控件上
    
    // 设置cell信息
    self.textLabel.text = item[@"title"];
    if (item[@"icon"] && [item[@"icon"] length] > 0) {
        self.imageView.image = [UIImage imageNamed:item[@"icon"]];
    }
    
    // 设置subTitle
    self.detailTextLabel.text = item[@"subTitle"];
    
    // 如果item里面 isRed 是 yes 那么设置成红色
    if (item[@"isRed"]) {
        self.detailTextLabel.textColor = [UIColor redColor];
    }
    
    // 获取 accessory的类型
    NSString* accessoryType = item[@"accessoryType"]; // @"UISwitch"
    
    Class Clz = NSClassFromString(accessoryType); // UISwitch
    
    UIView* obj = [[Clz alloc] init]; // UISwitch对象
    
    // 判断这个对象的类型
    if ([obj isKindOfClass:[UIImageView class]]) {
        // 设置图片
        UIImageView* imageView = (UIImageView*)obj;
        imageView.image = [UIImage imageNamed:item[@"accessoryContent"]];
        [imageView sizeToFit];
    }
    else if ([obj isKindOfClass:[UISwitch class]]) {
        // 对开关进行监听
        UISwitch* switcher = (UISwitch*)obj;
        [switcher addTarget:self action:@selector(switcherChange:) forControlEvents:UIControlEventValueChanged];
        
        // 获取ud单例
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        // 把开关的状态设置成沙盒的状态
        switcher.on = [ud boolForKey:self.item[@"switchKey"]];
    }
    
    self.accessoryView = obj;
}

// 开关状态的监听
- (void)switcherChange:(UISwitch*)sender
{
    // 获取ud单例
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    // 保存状态
    [ud setBool:sender.isOn forKey:self.item[@"switchKey"]];
    
}

@end
