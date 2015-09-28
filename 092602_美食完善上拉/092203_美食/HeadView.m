//
//  HeadView.m
//  092203_美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()
@property(weak,nonatomic)UIScrollView * scrollView;

@property(strong,nonatomic)UIButton * button;


@property(copy,nonatomic)NSString * beginText;
@property(copy,nonatomic)NSString * dragingText;
@property(copy,nonatomic)NSString * refreshText;

@end

@implementation HeadView

#pragma mark 类方法创建
+(id)headView{
    return [[self alloc] init];
}
-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
#pragma mark 把self加载到superView上
-(void)willMoveToSuperview:(UIView *)newSuperview{
    UITableView * table = (UITableView *)newSuperview;
    
    CGFloat selfW = table.frame.size.width;
    CGFloat selfH = 60;
    CGFloat selfX = 0;
    CGFloat selfY = -64;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
    

}
-(void)didMoveToSuperview{
    self.scrollView = (UITableView *)self.superview;
    // self.scrollView = self.superview;
}

#pragma mark 设置监听者
-(void)setScrollView:(UIScrollView *)scrollView{
    
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if(self.status == HeadDidLoading){
        return;
    }
    if(self.scrollView.isDragging){
        CGFloat min = -64;
        CGFloat offSetY = self.scrollView.contentOffset.y;
        if(offSetY < min && offSetY > min - 60){
            [self setStatus:HeadDidDrag];
        }else if(offSetY < min - 60){
            [self setStatus:HeadDidDraging];
        }
    }else{
        if(self.status == HeadDidDraging){
            [self setStatus:HeadDidLoading];
            self.scrollView.contentInset = UIEdgeInsetsMake(130, 0, 49, 0);
            [self.delegate headSuccess:self];
            if(self.beginBlock){
                self.beginBlock();
                
            }
            
        }
    }
    
    
}
#pragma mark 设置状态
-(void)setStatus:(HeadStatus)status{
    _status = status;
    NSString * title = [self titleWithStutus:status];
   
    switch (status) {
        case HeadDidDrag:
            [self.button setTitle:title forState:UIControlStateNormal];
            
            break;
        case HeadDidDraging:
            [self.button setTitle:title forState:UIControlStateNormal];
            break;

        case HeadDidLoading:
            [self.button setTitle:title forState:UIControlStateNormal];
           
            break;

            
        default:
            break;
    }
}
#pragma mark 设置button
-(UIButton *)button{
    if(_button == nil){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button .frame = CGRectMake(50, 10, 150, 30);
        [self addSubview:button];
        _button = button;
    }
    return _button;
}
#pragma mark 停止动画
-(void)stopAnimotion{
    self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self clear];
}
-(void)clear{
    [_button removeFromSuperview];
    _button = nil;
    self.status = HeadDidDrag;
}
-(void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
#pragma mark 设置title
-(void)setTitle:(NSString *)title status:(HeadStatus)status{
   
    if(status == HeadDidDrag){
        _beginText = title;
    }else if(status == HeadDidDraging){
        _dragingText = title;
    }else if (status == HeadDidLoading){
        _refreshText = title;
        
    }
}
-(NSString *)titleWithStutus:(HeadStatus)status{
    NSString * title = nil;
    if(status == HeadDidDrag){
        title = _beginText ? _beginText : @"拖拽开始刷新";
    }else if(status == HeadDidDraging){
        title = _dragingText ? _dragingText : @"松开即可刷新";
    }else if(status == HeadDidLoading){
        title = _refreshText ? _refreshText : @"正在努力刷新";
    }
    
    return title;
}



@end


















