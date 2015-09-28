//
//  UIScrollView+Refresh.h
//  092203_美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicRefreshMenu.h"


@interface UIScrollView (Refresh)<FootViewDelegate,HeadViewDelegate>



- (void)addRefreshHeaderViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh;

- (void)addRefreshFooterViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh;

-(void)endHeadSuccessRefresh;
-(void)endFootSuccessRefresh;

-(void)endHeadFailRefresh;
-(void)endFootFailRefresh;
@end
