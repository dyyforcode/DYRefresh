//
//  GoodFoodModel.h
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@interface GoodFoodModel : NSObject

@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * cardNumber;
@property(copy,nonatomic)NSString * note;
@property(copy,nonatomic)NSString * icon;

+(id)subjectWithDictionary:(NSDictionary *)dict;
@end
