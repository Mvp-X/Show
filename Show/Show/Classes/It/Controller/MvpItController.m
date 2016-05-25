//
//  MvpItController.m
//  Show
//
//  Created by Colorful on 16/5/24.
//  Copyright © 2016年 Mvp. All rights reserved.
//

#import "MvpItController.h"
#import "MvpCarGroup.h"
#import "MvpCar.h"
//Setting控制器代码创建
#import "MvpSettingController.h"


@interface MvpItController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic,strong) NSArray *carGroupArray;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation MvpItController


- (NSArray *)carGroupArray{
    if (_carGroupArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cars_total" ofType:@"plist"]];
        
        //1.定义可变数组
        NSMutableArray *nmArray = [NSMutableArray array];
        //2。遍历字典数组
        for (NSDictionary *dict in array) {
            //3.字典转模型
            MvpCarGroup *carGroup = [MvpCarGroup carGroupWithDict:dict];
            
            //4.讲模型添加到可变数组中
            [nmArray addObject:carGroup];
        }
        //5.讲模型的可变数组赋值给字典数组
        _carGroupArray = nmArray;
    }
    
    return _carGroupArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    //隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置分割线
//    self.tableView.separatorColor = [UIColor redColor];
    
//--------此处填写加载数据方法--------
    
}

-(void)setNavBarItem{
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(Setting)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(PushMore)];

}

-(void)Setting{

    MvpSettingController *ST = [[MvpSettingController alloc]initWithStyle:UITableViewStylePlain];
    // 常见问题的按钮 - 不要写在setting的viewdidload中 因为会有复用
    UIBarButtonItem* helpItem = [[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:nil];
    ST.navigationItem.rightBarButtonItem = helpItem;
    
    // 设置标题
    ST.navigationItem.title = @"设置";
    ST.plistName = @"Setting";
    
    [self.navigationController pushViewController:ST animated:YES];

//    [self presentViewController: ST animated:NO completion:nil];
    

}

-(void)PushMore{

    [self presentViewController:[[UIStoryboard storyboardWithName:@"More" bundle:nil]instantiateInitialViewController] animated:NO completion:nil];

}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.carGroupArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MvpCarGroup *carGroup = self.carGroupArray[section];
    
    return carGroup.cars.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *resuseId = @"carGroup";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuseId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuseId];
    }
    
    // 根据组获取对应的组数据
    MvpCarGroup *carGroup = self.carGroupArray[indexPath.section];
    
    // 在根据组数据获取对应的行数据
    MvpCar *car = carGroup.cars[indexPath.row];
    
    //设置属性
    cell.imageView.image = [UIImage imageNamed:car.icon];
    
    cell.textLabel.text = car.name;
    
    //返回cell
    return cell;
    
    
}

//加载组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    MvpCarGroup *carGroup = self.carGroupArray[section];
    
    return carGroup.title;
    
}


#pragma mark-- 右侧索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
        NSMutableArray *tempArray = [NSMutableArray array];
    
        //组成一个title数组
        for (MvpCarGroup *carGroup in self.carGroupArray) {
    
            [tempArray addObject:carGroup.title];
    
        }
    
        return tempArray;
    //或以下一句话
//    return [self.carGroupArray valueForKeyPath:@"title"];
    
}

#pragma mark -选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"点击了--%ld 组，点击了--%ld 行",indexPath.section,indexPath.row);
    
    /**
     Title: 标题
     message:描述信息
     delegate：代理对象
     cancelButtonTitle :取消按钮的标题
     otherButtonTitles:其他按钮的标题
     */
    //初始化
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改品牌名称" message:@"修改您选中的品牌名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
    //    UIAlertViewStyleDefault = 0,  默认不显示
    //    UIAlertViewStyleSecureTextInput,  安全的输入框,密码输入框
    //    UIAlertViewStylePlainTextInput,   普通的输入框
    //    UIAlertViewStyleLoginAndPasswordInput 登陆和密码的输入框
    //设置输入框的样式
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // 根据组获取对应的组数据
    MvpCarGroup *carGroup = self.carGroupArray[indexPath.section];
    
    // 在根据组数据获取对应的行数据
    MvpCar *car = carGroup.cars[indexPath.row];
    
   //记录indexPath
    self.indexPath = indexPath;
    
    //获取对话框中的输入框
    
    //    UITextField *textField = [alertView textFieldAtIndex:0];
    //    textField.text = hero.name;
    [alertView textFieldAtIndex:0].text = car.name;
    
    //显示
    [alertView show];
    
}

/**
 *  对话框按钮的响应
 //在任何情况下都是0
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        //1. 获取数据
        NSString *upDate = [alertView textFieldAtIndex:0].text;
        
//        NSLog(@"修改-->%@",upDate);
        //2. 更新数据
        // 根据组获取对应的组数据
        MvpCarGroup *carGroup = self.carGroupArray[self.indexPath.section];
        // 在根据组数据获取对应的行数据
        MvpCar *car = carGroup.cars[self.indexPath.row];
        //修改
        car.name = upDate;
        //3.刷新UITableview
        //第一种 调用全局刷新
        //  [self.tableView reloadData];
        //第二种局部刷新--可以添加动画效果
        //传入是数组,代表可以同时刷新多行,但多行的动画效果一样--NSArray *array = @[]
        
        [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
    }
    
}

#pragma mark - 删除对应行的cell数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 根据组获取对应的组数据
    MvpCarGroup *carGroup = self.carGroupArray[self.indexPath.section];
    // 在根据组数据获取对应的行数据
    [carGroup.cars removeObjectAtIndex:indexPath.row];
//    NSLog(@"当前组 -->%ld,-->当前的行-->%ld",indexPath.section,indexPath.row);
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark -设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
    
}

@end
