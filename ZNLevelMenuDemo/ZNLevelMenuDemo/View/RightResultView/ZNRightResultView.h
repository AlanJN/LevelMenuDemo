//
//  ZNRightResultView.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuResultCell;

@protocol ZNRightResultViewDelegate <NSObject>

- (void)foodCell:(MenuResultCell *)cell addFood:(UIButton *)button;

@end

@interface ZNRightResultView : UITableView

@property (nonatomic ,strong) NSArray * foodsArray;
@property (nonatomic ,weak) id<ZNRightResultViewDelegate>foodViewDelegate;
@end
