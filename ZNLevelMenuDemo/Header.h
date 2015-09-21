//
//  Header.h
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/20.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#ifndef ZNLevelMenuDemo_Header_h
#define ZNLevelMenuDemo_Header_h

#define ColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#endif
