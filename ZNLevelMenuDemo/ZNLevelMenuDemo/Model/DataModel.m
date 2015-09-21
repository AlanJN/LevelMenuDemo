//
//  DataModel.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/20.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+(DataModel *)getDataFromDictionary:(NSDictionary *)dic{

    if (dic) {
        
        DataModel * model = [[DataModel alloc] init];
        
        model.imageName = dic[@"image"];
        model.foodName = dic[@"name"];
        model.salesNum = dic[@"salesNum"];
        model.foodPrice = dic[@"price"];
        model.foodId = dic[@"foodId"];
        
        return model;
    }
    
    return nil;
}

@end
