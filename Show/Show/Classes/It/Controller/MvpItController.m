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

@interface MvpItController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *carGroupArray;


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
    
//--------此处填写加载数据方法--------
    
}

-(void)setNavBarItem{
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(PushMore)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(Login)];

}

-(void)Login{


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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
    
}
@end
