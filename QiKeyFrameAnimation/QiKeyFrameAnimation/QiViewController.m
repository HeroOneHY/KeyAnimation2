//
//  QiViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiViewController.h"

@interface QiViewController ()

@property (nonatomic, strong) CABasicAnimation *layerAnimation;

@end

@implementation QiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 初始化网格
    CGFloat minSide = fminf(self.view.bounds.size.width, self.view.bounds.size.height);
    _squareSide = minSide / 10; //每个小格的宽度
    
    NSUInteger rowCount = (NSUInteger)(self.view.bounds.size.height / _squareSide); //行数
    NSUInteger columnCount = (NSUInteger)(self.view.bounds.size.width / _squareSide); //列数
    
    for (NSUInteger i = 0; i < rowCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(.0, i * _squareSide, self.view.bounds.size.width, 1.0)];
        line.backgroundColor = [UIColor grayColor];
        [self.view addSubview:line];
    }
    for (NSUInteger i = 0; i < columnCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i * _squareSide, .0, 1.0, self.view.bounds.size.height)];
        line.backgroundColor = [UIColor grayColor];
        [self.view addSubview:line];
    }
    
    // 初始化imageView
    _imageView = [[UIImageView alloc] initWithFrame:(CGRect){.0, .0, _squareSide, _squareSide}];
    _imageView.center = CGPointMake(_squareSide, _squareSide);
    _imageView.image = [UIImage imageNamed:@"logo_qishare"];
    [self.view addSubview:_imageView];
    
    // 初始化动画
    _animation = [CAKeyframeAnimation animation];
    _animation.keyPath = @"position";
    _animation.delegate = self;
    _animation.duration = 2.0;
   // _animation.calculationMode = kCAAnimationLinear;
    //calculationMode控制动画的数学形式，比如kCAAnimationLinear那么不管怎样动画是匀速的
    _animation.timeOffset = 1.0; //控制动画的偏移时间,改变的是本地时间系
    //_animation.speed = 2.0; //速度越快消耗的时间越少
    _animation.repeatCount = 1.0;
    _animation.removedOnCompletion = NO; //决定当动画结束是否把动画移除；如果为YES，动画都已经移除了无论怎样都会回到原点
   // _animation.autoreverses = YES; //是否按原路径返回
    /*
     kCAFillModeRemoved: 动画结束回到原点
     kCAFillModeForwards：动画结束不回到原点
     kCAFillModeBackwards：动画结束回到原点,如果物体本身的位置和动画开始的位置不在一起，使用kCAFillModeBackwards物体会立即到达动画开始的位置
     */
    _animation.fillMode = kCAFillModeForwards;
    _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [CAMediaTimingFunction functionWithControlPoints:0 :0 :0 :0];
    // shape layer ，为了画椭圆图形
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineWidth = 2.0;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;

    // shape layer的动画
    _layerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _layerAnimation.fromValue = @.0;
    _layerAnimation.toValue = @1.0;
    _layerAnimation.delegate = self;
    _layerAnimation.duration = self.animation.duration;
    _layerAnimation.timingFunction = self.animation.timingFunction;
}


#pragma mark - Public functions

- (void)startAnimation:(BOOL)start {
    
    if (start) {
        /*
         系统时间是手机硬件时间，这个时间是从开机到现在运行的时间秒数，可以看做是以手机开机为开始的一个时间戳；系统时间的获取可以通过CACurrentMediaTime()方法来得到。
         一个动画对象中的时间是基于父对象的时间来计算的
         t = (tp - begin) * speed + timeOffset
         t - 本对象的时间 可以是CALayer对象或者CAAnimation对象；tp - 父对象的时间，可能是superLayer和CAAnimationGroup；begin - beginTime；默认情况下 t = tp , 即 本对象的时间和父对象的时间是一样的。(begin=0, speed=1, timeOffset=0，默认值)。
         
         */
          _animation.beginTime = CACurrentMediaTime()+3;
        [_imageView.layer addAnimation:_animation forKey:@"animation"];
    }
    else {
        [_imageView.layer removeAnimationForKey:@"animation"];
    }
    
    if (start) {
        [self.view.layer addSublayer:_shapeLayer];
        [_shapeLayer addAnimation:_layerAnimation forKey:@"animation"];
    }
    else {
        [_shapeLayer removeFromSuperlayer];
        [_shapeLayer removeAnimationForKey:@"animation"];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",_imageView.layer.animationKeys);
}
#pragma mark - Action functions

- (IBAction)startAnimationButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;

    [self startAnimation:sender.selected];
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"%s", __func__);
}

@end
