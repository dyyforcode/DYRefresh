//
//  ContentView.m
//  092203_美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ContentView.h"

#import "GoodFoodModel.h"
#import "GoodFoodTableViewCell.h"

#import "HeadTableView.h"


#import "DYRefresh.h"

@interface ContentView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;



@property(weak,nonatomic)HeadTableView * head;



@end

@implementation ContentView
-(HeadTableView *)head{
    if(_head == nil){
        HeadTableView * head = [[HeadTableView alloc] init];
        [self addSubview:head];
        _head = head;
    }
    return _head;
}


+(id)contentView{
    return [[self alloc] init];
}
-(void)setSubArray:(NSMutableArray *)subArray{
    _subArray = subArray;
    [self.tableView reloadData];
}
-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
    self.head.imageArray = imageArray;
    _tableView.tableHeaderView = self.head;
    [self.tableView reloadData];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.frame = newSuperview.bounds;
    CGSize size = self.bounds.size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    _tableView.rowHeight = 100;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    self.head.frame = CGRectMake(0, 64, self.frame.size.width, 150);
    
    __weak typeof(self) ws = self;
    [_tableView addRefreshHeaderViewWithAniViewClass:[BasicRefreshMenu class] beginRefresh:^{
        [ws performSelector:@selector(dataLoad) withObject:nil afterDelay:3];
     
    }];
    [_tableView addRefreshFooterViewWithAniViewClass:[BasicRefreshMenu class] beginRefresh:^{
        [ws performSelector:@selector(dataLoad) withObject:nil afterDelay:3];
    }];
  
       
}
-(void)dataLoad{
//      //下拉刷新，上拉加载，success
//    [_tableView endHeadSuccessRefresh];
//    [_tableView endFootSuccessRefresh];
    
    
    
      //下拉刷新，上拉加载，fail
    [_tableView endHeadFailRefresh];
    [_tableView endFootFailRefresh];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodFoodTableViewCell * cell = [GoodFoodTableViewCell cellWithTableView:tableView];
    GoodFoodModel * model = self.subArray[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:model.icon];
    cell.nameLabel.text = model.title;
    cell.numLabel.text = [NSString stringWithFormat:@"%@帖",model.cardNumber];
    cell.contentLabel.text = model.note;
        return cell;
}

@end
