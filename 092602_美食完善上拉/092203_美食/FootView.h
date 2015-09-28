//
//  FootView.h
//  092203_美食
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BasicRefreshMenu.h"

typedef enum FootStatus{
    UIScroolViewDidDrag,
    UIScrollViewDidDraging,
    UIScrollViewDidLoading
}FootStatus;

@class FootView;
@protocol FootViewDelegate <NSObject>

-(void)footSuccess:(FootView *)footView;

@end


@interface FootView : UIView


@property(nonatomic,assign)FootStatus status;
@property(weak,nonatomic)id<FootViewDelegate>delegate;

@property(nonatomic,copy)void (^beginBlock)();

-(void)setTitle:(NSString *)title status:(FootStatus)status;
+(id)footView;
-(void)stopAnimotion;
@end
