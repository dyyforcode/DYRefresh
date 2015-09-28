//
//  AddModel.h
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddModel : NSObject
@property(copy,nonatomic)NSString * name;
@property(copy,nonatomic)NSString * icon;
+(id)subjectWithDictionary:(NSDictionary *)dict;
@end
