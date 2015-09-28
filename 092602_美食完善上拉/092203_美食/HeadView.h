//
//  HeadView.h
//  092203_美食
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BasicRefreshMenu.h"

typedef enum HeadStatus{
    HeadDidDrag,
    HeadDidDraging,
    HeadDidLoading
}HeadStatus;

@class HeadView;
@protocol HeadViewDelegate <NSObject>

-(void)headSuccess:(HeadView *)headView;

@end


@interface HeadView : UIView


@property(nonatomic,assign)HeadStatus status;
@property(weak,nonatomic)id<HeadViewDelegate>delegate;

@property(nonatomic,copy)void (^beginBlock)();

-(void)setTitle:(NSString *)title status:(HeadStatus)status;
+(id)headView;
-(void)stopAnimotion;
@end
