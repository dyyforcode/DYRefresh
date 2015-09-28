//
//  NSObject+Model.m
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)
+(id)objectWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
-(id)initWithDictionary:(NSDictionary *)dict{
    if(self = [self init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
