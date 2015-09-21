//
//  DataModel.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/20.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic ,strong) NSString * imageName;             //图片
@property (nonatomic ,strong) NSString * foodId;                //食物Id
@property (nonatomic ,strong) NSString * foodName;              //名字
@property (nonatomic ,strong) NSString * salesNum;              //销量
@property (nonatomic ,strong) NSString * foodPrice;             //价格
@property (nonatomic ,strong) NSString * currentNum;            //当前个数
+(DataModel *)getDataFromDictionary:(NSDictionary *)dic;

@end
