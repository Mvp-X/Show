//
//  MvpSettingController.m
//  Show
//
//  Created by Colorful on 16/5/26.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpSettingController.h"
#import "MvpSettingCell.h"

@interface MvpSettingController ()<UITableViewDelegate,UITableViewDataSource>

//记录数据的数组
@property (strong, nonatomic) NSArray* groups;

@end

@implementation MvpSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置左上角返回按钮--通过图片设置
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = item;
    
}

//初始化组样式的TabbleView
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

//懒加载解析
- (NSArray*)groups
{
    if (_groups == nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
        //解析成array
        _groups = [NSArray arrayWithContentsOfFile:path];
    }
    return _groups;
}

-(void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    // 获取组
    NSDictionary* group = self.groups[section];
    // 获取这个组的所有的cell信息
    NSArray* items = group[@"items"];
    return items.count;
}

// 设置cell
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 1.获取数据
    // 获取组
    NSDictionary* group = self.groups[indexPath.section];
    // 获取cell的数组
    NSArray* items = group[@"items"];
    // 获取cell的信息
    NSDictionary* item = items[indexPath.row];
    
    // 2.创建cell
    MvpSettingCell* cell = [MvpSettingCell settingCellWithTableView:tableView andItem:item];
    
    // 3.给赋值数据
    cell.item = item;
    
    // 4.返回cell
    return cell;
}

// 选中cell方法
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 获取组
    NSDictionary* group = self.groups[indexPath.section];
    // 获取组内的所有的cell
    NSArray* items = group[@"items"];
    // 获取cell的信息
    NSDictionary* item = items[indexPath.row];
    
    // 判断是否有targetvc的key或这个key是否有值
    if (item[@"targetVC"] && [item[@"targetVC"] length] > 0) {
        
        // 跳转到的控制器的类型的字符串
        NSString* targetVC = item[@"targetVC"];
        // 把跳转到的控制器的类型的字符串 转化成类型
        Class Clz = NSClassFromString(targetVC);
        // 创建跳转到的控制器的对象
        UIViewController* vc = [[Clz alloc] init];
        
        // 判断是不是setting的类型 如果是给一个需要加载的plist的名字
        if ([vc isKindOfClass:[MvpSettingController class]]) {
            MvpSettingController* setting = (MvpSettingController*)vc;
            setting.plistName = item[@"plistName"];
        }
        
        // 设置标题
        vc.navigationItem.title = item[@"title"];
        
        // 跳转到这个控制器
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (item[@"funcName"] && [item[@"funcName"] length] > 0) {
        // 获取要执行方法的字符串
        NSString* funcName = item[@"funcName"];
        
        // 通过字符串转化成某一个方法(SEL)
        SEL selector = NSSelectorFromString(funcName);
    //*******************忽略报黄*******************
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 执行某一个方法
        [self performSelector:selector];
#pragma clang diagnostic pop
    //*******************忽略报黄*******************
    }
}


// 设置header
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取组
    NSDictionary* group = self.groups[section];
    return group[@"header"];
}

// 设置footer
- (NSString*)tableView:(UITableView*)tableView titleForFooterInSection:(NSInteger)section
{
    // 获取组
    NSDictionary* group = self.groups[section];
    return group[@"footer"];
}

//设置组头组尾高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 25;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}

// 打电话
- (void)makeCall
{
    // 获取app
    UIApplication* app = [UIApplication sharedApplication];
    // 调用openUrl 协议头: tel
    [app openURL:[NSURL URLWithString:@"tel://10010"]];
}

// 发短信
- (void)makeSms
{
    // 获取app
    UIApplication* app = [UIApplication sharedApplication];
    // 调用openUrl 协议头: sms
    [app openURL:[NSURL URLWithString:@"sms://10010"]];
}

// 评分支持
- (void)mark
{
    // 获取app
    UIApplication* app = [UIApplication sharedApplication];
    // 调用openUrl
    [app openURL:[NSURL URLWithString:@"https://WWW.baidu.com.cn"]];
}


#pragma mark - AlertView 新方法
// 有funcName执行的方法----检查新版本
- (void)checkUpdate
{
    // 弹框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"检查新版本" message:@"您已经最新的版本了" preferredStyle:UIAlertControllerStyleAlert];
    // 创建一个 action
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
    // 添加一个action
    [alert addAction:action];
    
    // 弹框
    [self presentViewController:alert animated:YES completion:nil];
}

@end
