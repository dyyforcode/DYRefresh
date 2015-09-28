//
//  ViewController.m
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

#import "GoodFoodModel.h"

#import "AddModel.h"



#import "ContentView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,copy)NSMutableArray * dataArray;
@property(nonatomic,copy)NSMutableArray * subArray;

@property(nonatomic,copy)NSMutableArray * imageArray;




@end

@implementation ViewController

-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"quanquan.plist" ofType:nil];
        _dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _dataArray;
}
-(NSMutableArray *)subArray{
    if(_subArray == nil){
        _subArray = [NSMutableArray array];
        for(NSDictionary * dict in self.dataArray[1]){
            GoodFoodModel * model = [GoodFoodModel subjectWithDictionary:dict];
            [_subArray addObject:model];
            
        }
    }
    return _subArray;
}
-(NSMutableArray *)imageArray{
    if(_imageArray == nil){
        _imageArray = [NSMutableArray array];
        for(NSDictionary * dict in self.dataArray[0]){
            AddModel * model = [AddModel subjectWithDictionary:dict];
            [_imageArray addObject:model];
            
        }
    }
    return _imageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ContentView * contentView = [ContentView contentView];
    [self.view addSubview:contentView];
    contentView.subArray = self.subArray;
    contentView.imageArray = self.imageArray;
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
