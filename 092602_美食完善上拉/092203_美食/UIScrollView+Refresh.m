//
//  UIScrollView+Refresh.m
//  092203_美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIScrollView+Refresh.h"



#import "HeadView.h"
#import "FootView.h"

@interface UIScrollView ()



@end


@implementation UIScrollView (Refresh)
static HeadView * head = nil;
static FootView * foot = nil;

#pragma mark 添加下拉刷新，上拉加载
-(void)addRefreshHeaderViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh{
    HeadView * headerView = [HeadView headView];
    headerView.delegate = self;
    headerView.beginBlock = beginRefresh;

    
    [self addSubview:headerView];
    
}
-(void)addRefreshFooterViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh{
    
    
    FootView *footerView = [FootView footView];
    footerView.delegate = self;
    footerView.beginBlock = beginRefresh;
    

    [self addSubview:footerView];
    
}
#pragma mark 下拉刷新success，上拉加载success
-(void)endHeadSuccessRefresh{
    [self performSelector:@selector(headDoSuccess) withObject:nil];
}
-(void)endFootSuccessRefresh{
    [self performSelector:@selector(success) withObject:nil];
}

#pragma mark 下拉刷新完成，上拉加载完成
-(void)success{
    [foot stopAnimotion];
    NSLog(@"加载完成");
    foot = nil;
}
-(void)headDoSuccess{
    [head stopAnimotion];
    NSLog(@"刷新完成");
    head = nil;
}


#pragma mark 下拉刷新fail，上拉加载fail
-(void)endHeadFailRefresh{
    [self headDoFail];
}
-(void)endFootFailRefresh{
    [self footDoFail];
}

#pragma mark 下拉刷新失败，上拉加载失败
-(void)headDoFail{
    [head stopAnimotion];
    NSLog(@"刷新失败");
}
-(void)footDoFail{
    [foot stopAnimotion];
    NSLog(@"加载失败");
}


#pragma mark 实现协议方法
-(void)headSuccess:(HeadView *)headView{
    head = headView;
}
-(void)footSuccess:(FootView *)footView{
    foot = footView;
}




@end
