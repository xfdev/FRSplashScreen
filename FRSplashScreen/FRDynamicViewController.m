//
//  FRDynamicViewController.m
//  FRSplashScreen
//
//  Created by myBaby on 16/11/26.
//  Copyright © 2016年 github.com/xfdev. All rights reserved.
//

#import "FRDynamicViewController.h"

#import <pop/POP.h>

@interface FRDynamicView : UIImageView

@end

@implementation FRDynamicView

//- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
//    return UIDynamicItemCollisionBoundsTypeEllipse;
//}

@end


#define SCREEN_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT       [[UIScreen mainScreen] bounds].size.height

@interface FRDynamicViewController ()

@property (nonatomic, strong) FRDynamicView *testView;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *graBehavior;// 重力行为
@property (nonatomic, strong) UICollisionBehavior *collBehavior;// 边界碰撞行为

@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;// 吸附行为

@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;// 物体属性

@property (nonatomic, strong) UIPushBehavior *pushBehavior;// 外力行为

@end

@implementation FRDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Dynamic";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(-200, 0, SCREEN_WIDTH + 200, SCREEN_HEIGHT);
    [self.view addSubview:bgView];
    
    
    
    
    
    __weak __typeof(&*self)wSelf = self;
    
    self.testView = [FRDynamicView new];
    self.testView.image = [UIImage imageNamed:@"image"];
    self.testView.backgroundColor = [UIColor whiteColor];
    self.testView.frame = CGRectMake(120, 250, 50, 50);
    [self.testView.layer setCornerRadius:25];
    
    [bgView addSubview:self.testView];
    
//    UIView *line = [UIView new];
//    line.frame = CGRectMake(10, 200, 300, 10);
//    line.backgroundColor = [UIColor whiteColor];
//    [bgView addSubview:line];
    
    // 这里的动力执行者DynamicAnimator必须是全剧状态，不然会被释放，之后就停止执行
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:bgView];
    self.animator.delegate = self;
    
    self.graBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.testView]];
    
    self.collBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.testView]];
    self.collBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collBehavior.collisionDelegate = self;
    
    CGRect frame1 = CGRectMake(0+200, SCREEN_HEIGHT - 20, SCREEN_WIDTH, 1);
//    UIView *line1 = [UIView new];
//    line1.frame = frame1;
//    line1.backgroundColor = [UIColor redColor];
//    [bgView addSubview:line1];
    
    CGRect frame2 = CGRectMake(SCREEN_WIDTH/2+200, SCREEN_HEIGHT - 150, SCREEN_WIDTH/2, 1);
//    UIView *line2 = [UIView new];
//    line2.frame = frame2;
//    line2.backgroundColor = [UIColor redColor];
//    [bgView addSubview:line2];
    
    [self.collBehavior addBoundaryWithIdentifier:@"bottom1" fromPoint:CGPointMake(frame1.origin.x, frame1.origin.y) toPoint:CGPointMake(frame1.origin.x + frame1.size.width, frame1.origin.y)];
    
    [self.collBehavior addBoundaryWithIdentifier:@"bottom2" fromPoint:CGPointMake(frame2.origin.x, frame2.origin.y) toPoint:CGPointMake(frame2.origin.x + frame2.size.width, frame2.origin.y)];
    
    self.collBehavior.action = ^() {
        
//        NSLog(@"frm = %@",NSStringFromCGRect(wSelf.testView.frame));
        
    };
    
    
//    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.testView attachedToAnchor:nil];
    
    
    
    
    self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.testView]];
    self.itemBehavior.elasticity = 0.6;
    self.itemBehavior.density = 1;
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.testView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.4, 0.1);
    
    
    
    
    
    
    self.graBehavior.action = ^() {
        
        if (wSelf.testView.frame.size.width != 50.0 || wSelf.testView.frame.size.height != 50.0) {
//            NSLog(@"sel = %@",NSStringFromCGSize(wSelf.testView.frame.size));
        }
        
        
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"sel44 = %@",self.animator.behaviors);
    
    POPBasicAnimation *spring1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
    spring1.toValue = [NSValue valueWithCGSize:CGSizeMake(20, 20)];
    spring1.duration = 1.2;
    spring1.beginTime = CACurrentMediaTime() + 0.5;
    [self.testView.layer pop_addAnimation:spring1 forKey:@"size1.POPPropertyAnimation"];
    
    
    [self.animator addBehavior:self.graBehavior];
    [self.animator addBehavior:self.collBehavior];
    [self.animator addBehavior:self.itemBehavior];
    
    [self.animator addBehavior:self.pushBehavior];
}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
//    NSLog(@"111self.view = %@,tr = %@",self.testView,NSStringFromCGAffineTransform(self.testView.transform));
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
//    NSLog(@"222self.view = %@",self.testView);
//    self.testView.frame = CGRectMake(100, 0, 50, 50);
//    
//    [self.animator removeBehavior:self.graBehavior];
//    [self.animator removeBehavior:self.collBehavior];
//    
//    [self.animator addBehavior:self.graBehavior];
//    [self.animator addBehavior:self.collBehavior];
    
}



- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    
    CGFloat dy = -0.55;
    
    if ([(NSString *)identifier isEqualToString:@"bottom2"]) {
        
        POPBasicAnimation *center = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
        center.toValue = [NSValue valueWithCGPoint:CGPointMake(200 + 320/2, SCREEN_HEIGHT/2)];
        center.duration = 0.5;
//        spring1.beginTime = CACurrentMediaTime() + 0.5;
        [self.testView pop_addAnimation:center forKey:@""];
        
        POPBasicAnimation *size = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
        //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
        size.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
        size.duration = 0.5;
        //        spring1.beginTime = CACurrentMediaTime() + 0.5;
        [self.testView.layer pop_addAnimation:size forKey:@""];
        
        [size setAnimationDidReachToValueBlock:^(POPAnimation *animation) {
            
            POPBasicAnimation *size2 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
            //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
            size2.toValue = [NSValue valueWithCGSize:CGSizeMake(SCREEN_HEIGHT, SCREEN_HEIGHT)];
            size2.duration = 0.5;
            //        spring1.beginTime = CACurrentMediaTime() + 0.5;
            [self.testView.layer pop_addAnimation:size2 forKey:@""];
            
            POPBasicAnimation *alp = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
            alp.toValue = @(0.0);
            alp.duration = 0.3;
            //        spring1.beginTime = CACurrentMediaTime() + 0.5;
            [self.testView pop_addAnimation:alp forKey:@""];
            
        }];
        
#warning Here's a question ??? -- 这里有一个疑问？？？
        // 这里 removeAllBehaviors 不起作用，sel111，sel222，sel44都能打印所有的 behaviors ，WHY？？？？
//        NSLog(@"sel111 = %@",self.animator.behaviors);
//        [self.animator removeAllBehaviors];
//        NSLog(@"sel222 = %@",self.animator.behaviors);
        
        self.animator = nil;
        return;
    }
    
    [self.animator removeBehavior:self.pushBehavior];
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.testView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.3, dy);
    [self.animator addBehavior:self.pushBehavior];
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
