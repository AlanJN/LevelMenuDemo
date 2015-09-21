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
@property (nonatomic ,strong) UIView * bottomView;                          //底部view
@property (nonatomic ,strong) UIView * buttonView;                          //用来确定加号按钮的view
@property (nonatomic ,strong) UILabel * cartNumberLabel;                    //购物车数量
@property (nonatomic ,strong) UILabel * cartTotalPriceLabel;                //购物车总价

@property (nonatomic ,strong) DataModel * currentModel;                     //当前正在加入购物的食物的Model
@property (nonatomic ,assign) int totalNumber;                              //数量
@property (nonatomic ,assign) float totalPrice;                             //总价

@end

@implementation ZNViewController

#pragma mark - Lazy Loading

- (NSMutableArray *)menuArray{
    
    if (!_menuArray) {
        _menuArray = [[NSMutableArray alloc] init];
    }
    return _menuArray;
}

#pragma mark -

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
    
    _bottomView =[[UIView alloc]initWithFrame:(CGRect){0,kScreenHeight-50.f-64.f,kScreenWidth,50}];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    _shoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 32, 32)];
    self.shoppingCart.image = [UIImage imageNamed:@"shoppingCart"];
    [self.bottomView addSubview:self.shoppingCart];
    
    _cartNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shoppingCart.frame)-8, CGRectGetMinY(self.shoppingCart.frame)-3, 15, 15)];
    self.cartNumberLabel.backgroundColor = [UIColor whiteColor];
    self.cartNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.cartNumberLabel.font = [UIFont systemFontOfSize:8.f];
    self.cartNumberLabel.textColor = [UIColor redColor];
    self.cartNumberLabel.layer.cornerRadius = 7.5f;
    self.cartNumberLabel.layer.borderWidth = 0.5;
    self.cartNumberLabel.hidden = YES;
    self.cartNumberLabel.layer.borderColor = [UIColor redColor].CGColor;
    [self.bottomView addSubview:self.cartNumberLabel];
    
    _cartTotalPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.shoppingCart.frame)+20, 5, 150, 40)];
    self.cartTotalPriceLabel.textColor=[UIColor redColor];
    self.cartTotalPriceLabel.font = [UIFont systemFontOfSize:14.f];
    [self.bottomView addSubview:self.cartTotalPriceLabel];
    
    [self setData];
}

//初始化数据
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
    
    _totalNumber = 0;
    _totalPrice = 0;
    self.cartNumberLabel.text = [NSString stringWithFormat:@"%d",self.totalNumber];
    self.cartTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.totalPrice];
}

#pragma mark - ZNLeftNavViewDelegate

- (void)navMenuClickIndexPathRow:(NSMutableArray *)rightArray lastIndexPath:(NSIndexPath *)lastIndex currentIndexPath:(NSIndexPath *)currentIndex{
    _rightResultView.foodsArray = rightArray;
    [_rightResultView reloadData];
}

#pragma mark - ZNRightResultViewDelegate

- (void)foodCellChangeFoodModel:(DataModel *)model button:(UIButton *)button changeStatus:(FoodStatus)status{
    
    _currentModel = model;
    switch (status) {
        case FoodStatusAdd:
        {
            [self addFoodAnimationWithModel:model button:button];
        }
            break;
         case FoodStatusMinus:
        {
            [self minusFood];
        }
            break;
        default:
            break;
    }
}

//增加食物的动画
- (void)addFoodAnimationWithModel:(DataModel *)model button:(UIButton *)button{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.buttonView.hidden = YES;
    }
    self.buttonView.center = button.center;
    
    //创建运动Layer
    CALayer * transLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transLayer.opacity = 1.0;
    transLayer.backgroundColor = [UIColor redColor].CGColor;
    transLayer.frame = self.buttonView.frame;
    transLayer.cornerRadius = 5;
    
    /*  如果需要运动的是图片 只需将 buttonView 变为UIImageView 并执行以下代码
     transLayer.contents = self.buttonView.layer.contents;
     */
    
    [self.view.layer addSublayer:transLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath * movePath = [UIBezierPath bezierPath];
    
    //终点
    CGPoint endPoint = [self.view convertPoint:self.shoppingCart.center fromView:self.bottomView];
    
    //起点
    
    CGPoint startPoint = [self.view convertPoint:button.center fromView:button.superview];
    
    [movePath moveToPoint:startPoint];
    
    //终点是购物车  控制贝塞尔曲线的 控制点
    [movePath addQuadCurveToPoint:endPoint
                     controlPoint:CGPointMake(50,startPoint.y)];
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.7;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    [transLayer addAnimation:group forKey:@"opacity"];
    
    [self performSelector:@selector(addFoodFnished:) withObject:transLayer afterDelay:0.6];
}

- (void)minusFood{
    
    self.totalNumber -= 1;
    
    [self calculateTotalPrice:self.cartTotalPriceLabel.text status:FoodStatusMinus];
    
    if (self.totalNumber <= 0) {
        self.cartNumberLabel.hidden = YES;
        self.totalNumber = 0;
        return;
    }
    
    self.cartNumberLabel.hidden = NO;
    self.cartNumberLabel.text = [NSString stringWithFormat:@"%d",self.totalNumber];
}

#pragma mark - 添加食物完成

- (void)addFoodFnished:(CALayer *)layer{
    //移除并释放layer
    [layer removeFromSuperlayer];
    layer = nil;
    
    self.totalNumber += 1;
    self.cartNumberLabel.hidden = NO;
    self.cartNumberLabel.text = [NSString stringWithFormat:@"%d",self.totalNumber];
    
    [self calculateTotalPrice:self.cartTotalPriceLabel.text status:FoodStatusAdd];
}

- (void)calculateTotalPrice:(NSString *)currentPrice status:(FoodStatus)status{
    
    //分离一下字符串
    NSString * price = [currentPrice substringFromIndex:1];
    self.totalPrice = [price floatValue];
    
    if (status == FoodStatusAdd) {
        self.totalPrice += [self.currentModel.foodPrice floatValue];
    }else{
        self.totalPrice -= [self.currentModel.foodPrice floatValue];
    }
    
    self.cartTotalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.totalPrice];
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
