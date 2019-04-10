//
//  QiValuesViewController.m
//  QiKeyFrameAnimation
//
//  Created by huangxianshuai on 2018/10/30.
//  Copyright © 2018年 qishare. All rights reserved.
//

#import "QiValuesViewController.h"

@interface QiValuesViewController ()

@end

@implementation QiValuesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    self.animation.values = @[[NSValue valueWithCGPoint:(CGPoint){0,0}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 1}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 2, self.squareSide * 5}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 5, self.squareSide * 5}],
                              [NSValue valueWithCGPoint:(CGPoint){self.squareSide * 5, self.squareSide * 7}]];
    self.animation.keyTimes = @[@.0, @.1, @.5, @.8, @1.0]; //第一个动画0s开始，duration*0.1时刻到达第二个点；第二个点duration*0.1开始，duration*0.5到达第三个点
    // self.animation.calculationMode = kCAAnimationPaced;// 可以替代上面的keyTimes实现匀速效果
}

@end
