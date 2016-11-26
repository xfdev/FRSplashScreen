//
//  FRDynamicViewController.m
//  FRSplashScreen
//
//  Created by myBaby on 16/11/26.
//  Copyright © 2016年 github.com/xfdev. All rights reserved.
//

#import "FRDynamicViewController.h"

#import <pop/POP.h>

@interface FRDynamicView : UIImageView <UIDynamicItem>

@end

@implementation FRDynamicView

- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
    return UIDynamicItemCollisionBoundsTypeEllipse;
}

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
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:bgView];
    self.animator.delegate = self;
    
    self.graBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.testView]];
    
    self.collBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.testView]];
    self.collBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collBehavior.collisionDelegate = self;
    
    CGRect frame1 = CGRectMake(0+200, SCREEN_HEIGHT - 20, SCREEN_WIDTH, 1);
    UIView *line1 = [UIView new];
    line1.frame = frame1;
    line1.backgroundColor = [UIColor redColor];
    [bgView addSubview:line1];
    
    CGRect frame2 = CGRectMake(SCREEN_WIDTH/2+200, SCREEN_HEIGHT - 150, SCREEN_WIDTH/2, 1);
    UIView *line2 = [UIView new];
    line2.frame = frame2;
    line2.backgroundColor = [UIColor redColor];
    [bgView addSubview:line2];
    
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
    self.pushBehavior.pushDirection = CGVectorMake(0.4, 0);
    
    
    
    
    
    
    self.graBehavior.action = ^() {
        
        if (wSelf.testView.frame.size.width != 50.0 || wSelf.testView.frame.size.height != 50.0) {
//            NSLog(@"sel = %@",NSStringFromCGSize(wSelf.testView.frame.size));
        }
        
        
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    POPBasicAnimation *spring1 = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
    //    spring1.fromValue = [NSValue valueWithCGSize:CGSizeMake(88, 88)];
    spring1.toValue = [NSValue valueWithCGSize:CGSizeMake(20, 20)];
    spring1.duration = 3;
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
    
    if (self.pushBehavior.pushDirection.dy == dy) {
        [self.animator removeAllBehaviors];
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
