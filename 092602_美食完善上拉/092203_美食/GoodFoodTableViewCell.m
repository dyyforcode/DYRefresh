//
//  GoodFoodTableViewCell.m
//  092203_美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GoodFoodTableViewCell.h"

@interface GoodFoodTableViewCell ()


@end

@implementation GoodFoodTableViewCell

+(id)cellWithTableView:(UITableView *)tableView{
    NSString * identifier = NSStringFromClass(self);
    /*  //cell必须在xib中标明cell的identifier
     GoodFoodTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        UINib * nib = [UINib nibWithNibName:@"GoodFoodTableViewCell" bundle:nil];
        cell = [nib instantiateWithOwner:nil options:nil];
    }
    return cell;
     */
    
    UINib * nib = [UINib nibWithNibName:@"GoodFoodTableViewCell" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
