//
//  MvpSettingCell.h
//  Show
//
//  Created by Colorful on 16/5/26.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MvpSettingCell : UITableViewCell

@property (strong, nonatomic) NSDictionary* item;

+ (instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary*)item;

@end
