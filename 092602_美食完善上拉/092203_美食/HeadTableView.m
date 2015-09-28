//
//  HeadTableView.m
//  Test
//
//  Created by qianfeng on 15/9/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadTableView.h"

#import "AddModel.h"

@interface HeadTableView ()
@property(strong,nonatomic)UIScrollView * scrollView;
@property(strong,nonatomic)UIPageControl * pageControll;

@end

@implementation HeadTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    [self create];
}
-(void)create{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat height = 170;
    
    
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    for(int i=0;i<[_imageArray count];i++){
        AddModel * model = _imageArray[i];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*size.width, 0, size.width, height)];
        
        imageView.image = [UIImage imageNamed:model.icon];
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(size.width*_imageArray.count, height);
    [self addSubview:_scrollView];
    
    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _pageControll.center = CGPointMake(size.width/2, height-20);
    _pageControll.numberOfPages = _imageArray.count;
    [self addSubview:_pageControll];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dealTimer:) userInfo:nil repeats:YES];
}

-(void)dealTimer:(NSTimer *)time{
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSInteger page = _pageControll.currentPage;
    page++;
    
    if(page >= _imageArray.count){
        page = 0;
    }
    _scrollView.contentOffset = CGPointMake(page*size.width, 0);
    _pageControll.currentPage = page;
}


@end
