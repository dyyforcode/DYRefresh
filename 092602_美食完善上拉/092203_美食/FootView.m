//
//  FootView.m
//  092203_美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FootView.h"

@interface FootView ()<UIScrollViewDelegate>
@property(weak,nonatomic)UIButton * btn;
@property(strong,nonatomic)UIScrollView * scrollView;

@property(weak,nonatomic)UIView * view;

@property(copy,nonatomic)NSString * beginText;
@property(copy,nonatomic)NSString * dragingText;
@property(copy,nonatomic)NSString * loadingText;

@end

@implementation FootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(id)footView{
    return [[self alloc] init];
}
#pragma mark 正在加载
-(UIView *)view{
    if(_view == nil){
        UIView * view = [[UIView alloc] init];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 150, 30)];
        label.text = [self titleWithStatus:UIScrollViewDidLoading];
        [view addSubview:label];
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.frame = CGRectMake(80, 10, 60, 30);
        [activity startAnimating];
        [view addSubview:activity];
        view.frame = self.bounds;
        [self addSubview:view];
       
        _view = view;
        
        
    }
    return _view;
}
#pragma mark 拖拽，松开
-(UIButton *)btn{
    if(_btn == nil){
       UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self addSubview:btn];
        _btn = btn;
    }
    return _btn;
}
#pragma mark 初始化
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor brownColor];
        
    }
    return self;
}
#pragma mark 设置状态
-(void)setStatus:(FootStatus)status{
    _status = status;
    switch (status) {
        case UIScroolViewDidDrag:
            
            [self.btn setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case UIScrollViewDidDraging:
            
            [self.btn setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case UIScrollViewDidLoading:
            
            self.btn.hidden = YES;
            self.view;
            break;
            
        default:
            break;
    }
}
#pragma mark 停止动画
-(void)stopAnimotion{
    self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [self clear];
}
-(void)clear{
    [_view removeFromSuperview];
    [_btn removeFromSuperview];
    self.status = UIScroolViewDidDrag;
}
-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
#pragma mark 设置title
-(void)setTitle:(NSString *)title status:(FootStatus)status{
    if(status == UIScroolViewDidDrag){
        _beginText = title;
    }else if(status == UIScrollViewDidDraging){
        _dragingText = title;
    }else if(status == UIScrollViewDidLoading){
        _loadingText = title;
    }
}
-(NSString *)titleWithStatus:(FootStatus)status{
    NSString * title = nil;
    if(status == UIScroolViewDidDrag){
        title = _beginText ? _beginText : @"拖拽加载更多";
    }else if(status == UIScrollViewDidDraging){
        title = _dragingText ? _dragingText : @"松开即可加载";
    }else if(status == UIScrollViewDidLoading){
        title = _loadingText ? _loadingText : @"正在努力加载";
    }
    return title;
}
#pragma mark 把self加载到superView上
-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    UITableView * table = (UITableView *)newSuperview;
    
    CGFloat selfW = table.frame.size.width;
    CGFloat selfH = 60;
    CGFloat selfX = 0;
    CGFloat selfY = self.scrollView.contentSize.height;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.btn.frame = CGRectMake(selfW/4, 10, selfW/2, 30);
    
}

-(void)didMoveToSuperview{
    self.scrollView = (UITableView *)self.superview;
    
}
#pragma mark 设置scrollView
-(void)setScrollView:(UIScrollView *)scrollView{
      [_scrollView removeObserver:self forKeyPath:@"contentOffset"];

     _scrollView= scrollView;
      
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
   
    
}
#pragma mark 设置监听者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self willMoveToSuperview:self.scrollView];
    if(self.scrollView.isDragging){
        CGFloat max = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
        CGFloat footHeight = self.frame.size.height ;
        if(self.scrollView.contentOffset.y > max+footHeight){
            [self setStatus:UIScrollViewDidDraging];
        
        }
        if(self.scrollView.contentOffset.y > max && self.scrollView.contentOffset.y < max+footHeight){
            [self setStatus:UIScroolViewDidDrag];
        }
        
    }
    else
    {
        if (self.status == UIScrollViewDidDraging)
        {
            [self setStatus:UIScrollViewDidLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(64, 0, self.frame.size.height, 0);
            
            [_delegate footSuccess:self];
            if(self.beginBlock){
                self.beginBlock();
            }

        }
        
    }//end else
   
}



@end
