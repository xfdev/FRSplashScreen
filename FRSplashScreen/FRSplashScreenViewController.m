//
//  FRSplashScreenViewController.m
//  FRSplashScreen
//
//  Created by sonny on 16/11/25.
//  Copyright © 2016年 github.com/xfdev. All rights reserved.
//

#import "FRSplashScreenViewController.h"

#import <pop/POP.h>



@interface FRSportView : UIImageView

@end

@implementation FRSportView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
//        self.layer.backgroundColor = [UIColor orangeColor].CGColor;
    }
    return self;
}

@end

#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

@interface FRSplashScreenViewController ()

@property (nonatomic, strong) FRSportView *sportView;

@end

@implementation FRSplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.title = @"POP";
    
    
}

- (void)start {
    
    if (self.sportView) {
        [self.sportView removeFromSuperview];
    }
    
    self.sportView = [[FRSportView alloc] init];
    self.sportView.image = [UIImage imageNamed:@"image"];
    self.sportView.frame = CGRectMake(-95, SCREEN_HEIGHT/2-64, 100, 100);
    [self.view addSubview:self.sportView];
    
    CFTimeInterval t = 0.5;
    
    // 阶段1
    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    spring.fromValue = [NSValue valueWithCGRect:CGRectMake(-95, SCREEN_HEIGHT/2-64, 100, 100)];
    spring.toValue = [NSValue valueWithCGRect:CGRectMake(20, SCREEN_HEIGHT-120, 88, 88)];
    [self.sportView pop_addAnimation:spring forKey:@"spring_kPOPViewCenter"];
    spring.duration = t;
    spring.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [spring setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
//        [self changeSpring1];// 阶段2
    }];
    
    // 按比例缩小
//    POPBasicAnimation *size1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
//    size1.toValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
//    size1.duration = t;
//    [self.sportView.layer pop_addAnimation:size1 forKey:@"size1_POPPropertyAnimation"];
//    NSLog(@"size1 = %@",size1);
    
    [self changeSpring1WithTime:t];// 阶段2
    
    
}
// 第一次形变
// 阶段2
- (void)changeSpring1WithTime:(CFTimeInterval)time {
    
//    CGFloat bottom = self.sportView.layer.frame.origin.y + self.sportView.layer.frame.size.height;
//    CGFloat x = self.sportView.layer.frame.origin.x;
    CFTimeInterval t = 0.1;
    
//    NSLog(@"bot = %f,x = %f",bottom,x);
    
    POPBasicAnimation *spring1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
//    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
    spring1.toValue = [NSValue valueWithCGSize:CGSizeMake(80, 70)];
    spring1.duration = t;
    spring1.beginTime = CACurrentMediaTime() + time - t;
    [self.sportView.layer pop_addAnimation:spring1 forKey:@"size1.POPPropertyAnimation"];
    
    POPBasicAnimation *springY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    springY.toValue = @(SCREEN_HEIGHT-150+70);
    springY.duration = t;
    springY.beginTime = CACurrentMediaTime() + time - t;
    [self.sportView.layer pop_addAnimation:springY forKey:@""];
    [springY setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
        [self path2];
    }];
    
//    POPBasicAnimation *springCenter = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
//    springCenter.toValue = [NSValue valueWithCGPoint:CGPointMake(x + 5, bottom - 18)];
//    [self.sportView.layer pop_addAnimation:springCenter forKey:@""];
}

- (void)path2 {
    
    // 向中间移动
    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 20, self.view.center.y + 20)];
    spring.duration = 0.7;
    [self.sportView pop_addAnimation:spring forKey:@"spring_kPOPViewCenter"];
    
    // 缩小
    POPBasicAnimation *size1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    size1.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
    size1.duration = 0.7;
    [self.sportView.layer pop_addAnimation:size1 forKey:@"size1_POPPropertyAnimation"];
    [size1 setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
        [self path3];
    }];
    
}

- (void)path3 {
    
    // 向中间移动
    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y + 90)];
    spring.duration = 0.5;
    [self.sportView pop_addAnimation:spring forKey:@"spring_kPOPViewCenter"];
    
    // 缩小
    POPBasicAnimation *size1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    size1.toValue = [NSValue valueWithCGSize:CGSizeMake(30, 30)];
    size1.duration = 0.5;
    [self.sportView.layer pop_addAnimation:size1 forKey:@"size1_POPPropertyAnimation"];
    [size1 setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
        [self path4];
    }];
    
}

- (void)path4 {
    
    // 向中间移动
    POPBasicAnimation *spring = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 10)];
    spring.duration = 0.5;
    [self.sportView pop_addAnimation:spring forKey:@"spring_kPOPViewCenter"];
    
    // 放大
    POPBasicAnimation *size1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    size1.toValue = [NSValue valueWithCGSize:CGSizeMake(80, 80)];
    size1.duration = 0.5;
    [self.sportView.layer pop_addAnimation:size1 forKey:@"size1_POPPropertyAnimation"];
    [size1 setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
        [self path5];
    }];
    
//    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    alpha.toValue = @(0.0);
//    alpha.duration = 0.7;
//    [self.sportView pop_addAnimation:alpha forKey:@"size1_POPPropertyAnimation"];
    
}

- (void)path5 {
    
    // 放大
    POPBasicAnimation *size1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    size1.toValue = [NSValue valueWithCGSize:CGSizeMake(390, 390)];
    size1.duration = 0.7;
    [self.sportView.layer pop_addAnimation:size1 forKey:@"size1_POPPropertyAnimation"];
    
    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.toValue = @(0.0);
    alpha.duration = 0.7;
    [self.sportView pop_addAnimation:alpha forKey:@"size1_POPPropertyAnimation"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
