//
//  ViewController.m
//  ZNLevelMenuDemo
//
//  Created by 李梓楠 on 15/9/19.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "ZNViewController.h"
#import "ZNLeftNavView.h"
#import "ZNRightResultView.h"
#import "Header.h"
#import "DataModel.h"
#import "MenuResultCell.h"

@interface ZNViewController ()<ZNLeftNavViewDelegate,ZNRightResultViewDelegate>

@property (nonatomic ,strong) ZNLeftNavView * leftNavView;                  //左侧导航
@property (nonatomic ,strong) ZNRightResultView * rightResultView;          //右侧食物
@property (nonatomic ,strong) NSMutableArray * menuArray;                   //数据源
@property (nonatomic ,strong) UIImageView * shoppingCart;                   //购物车


@end

@implementation ZNViewController


- (NSMutableArray *)menuArray{
    
    if (!_menuArray) {
        _menuArray = [[NSMutableArray alloc] init];
    }
    return _menuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"外卖商铺";
    self.view.backgroundColor = ColorRGBA(236, 236, 236, 1.f);
    _leftNavView = [[ZNLeftNavView alloc] initWithFrame:CGRectMake(0, 0, 80, kScreenHeight-64.f-50.f) style:UITableViewStylePlain];
    self.leftNavView.rowHeight = 50;
    self.leftNavView.leftNavDelegate=self;

    [self.view addSubview:self.leftNavView];
    
    [self setExtraCellLineHidden:self.leftNavView];
    
    _rightResultView = [[ZNRightResultView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftNavView.frame), 0, kScreenWidth-80, kScreenHeight-64.f-50.f) style:UITableViewStylePlain];
    self.rightResultView.rowHeight = 130;
    self.rightResultView.foodViewDelegate = self;
    [self.view addSubview:self.rightResultView];
    
    UIView *bottomView =[[UIView alloc]initWithFrame:(CGRect){0,kScreenHeight-50.f-64.f,kScreenWidth,50}];
    bottomView.backgroundColor = ColorRGBA(136, 136, 136, 1);
    [self.view addSubview:bottomView];
    
    _shoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 32, 32)];
    self.shoppingCart.image = [UIImage imageNamed:@"shoppingCart"];
    [bottomView addSubview:self.shoppingCart];
    
    [self setData];
}

#pragma mark - 初始化数据

- (void)setData{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"DataPlist" ofType:@"plist"];
    NSArray * array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    for (int i = 0; i<array.count; i++) {
        NSString * menuName = array[i][@"name"];
        NSArray * array1 = array[i][@"foods"];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSMutableArray * foodsArray = [[NSMutableArray alloc] init];
        for (int j=0; j<array1.count; j++) {
            DataModel * model = [DataModel getDataFromDictionary:array1[j]];
            [foodsArray addObject:model];
        }
        dic = [@{@"navName":menuName,@"foods":foodsArray} mutableCopy];
        
        [self.menuArray addObject:dic];
    }
    
    self.leftNavView.menuArray = self.menuArray;
    [self.leftNavView reloadData];
}

#pragma mark - ZNLeftNavViewDelegate

- (void)navMenuClickIndexPathRow:(NSMutableArray *)rightArray lastIndexPath:(NSIndexPath *)lastIndex currentIndexPath:(NSIndexPath *)currentIndex{
    _rightResultView.foodsArray = rightArray;
    [_rightResultView reloadData];
}

#pragma mark - ZNRightResultViewDelegate

- (void)foodCell:(MenuResultCell *)cell addFood:(UIButton *)button{
    
    //结束点
    CGPoint endpoint = [self.view convertPoint:self.shoppingCart.center fromView:self.shoppingCart.superview];
    
    //出发点
    CGPoint startPoint = [self.view convertPoint:button.center fromView:cell.contentView];
    
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.cornerRadius = 5.f;
    redView.layer.masksToBounds = YES;
    redView.hidden = NO;
    redView.center = button.center;
    
    //
    CALayer * layer = [CALayer layer];
    layer.contents = redView.layer.contents;
    layer.frame = redView.frame;
    layer.opacity = 1;
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    //贝塞尔曲线路径
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endpoint.x;
    float ey = endpoint.y;
    float x = sx + (ex - sx) / 3;
    float y = sy + (ey - sy) * 0.5 - 400;
//    CGPoint centerPoint=CGPointMake(x, y);
//    [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.path = path.CGPath;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.duration = 0.8;
//    animation.delegate = self;
//    animation.autoreverses = NO;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [layer addAnimation:animation forKey:@"buy"];
    
}

#pragma mark -

//隐藏多余cell分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
