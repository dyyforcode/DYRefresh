//
//  NSObject+Model.h
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)
+(id)objectWithDictionary:(NSDictionary *)dict;
-(id)initWithDictionary:(NSDictionary *)dict;
@end
