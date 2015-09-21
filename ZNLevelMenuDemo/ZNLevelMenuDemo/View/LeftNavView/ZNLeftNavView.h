//
//  ZNLeftNavView.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZNLeftNavViewDelegate <NSObject>

/**
 *  点击左侧导航 更新右侧食物
 *
 *  @param rightArray   食物数组
 *  @param lastIndex    上一次保存的Cell的Index  根据这个 可设置食物列表的 contentOffset
 *  @param currentIndex 当前的Cell的Index
 */
- (void)navMenuClickIndexPathRow:(NSMutableArray *)rightArray lastIndexPath:(NSIndexPath *)lastIndex currentIndexPath:(NSIndexPath *)currentIndex;

@end

@interface ZNLeftNavView : UITableView

@property (nonatomic ,strong) NSArray * menuArray;                       //菜单数组
@property (nonatomic ,weak) id<ZNLeftNavViewDelegate>leftNavDelegate;

@end
