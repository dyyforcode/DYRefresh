//
//  GoodFoodModel.m
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GoodFoodModel.h"

@implementation GoodFoodModel
+(id)subjectWithDictionary:(NSDictionary *)dict{
    return [self objectWithDictionary:dict];
}
-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@",_title];
}
@end
