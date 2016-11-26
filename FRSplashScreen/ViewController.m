//
//  ViewController.m
//  FRSplashScreen
//
//  Created by sonny on 16/11/25.
//  Copyright © 2016年 github.com/xfdev. All rights reserved.
//

#import "ViewController.h"

#import "FRSplashScreenViewController.h"
#import "FRDynamicViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat x = 100;
    CGFloat w = 120;
    CGFloat h = 50;
    
    [self createButtonWithTitle:@"POP" frame:CGRectMake(x, 100, w, h) tag:1];
    [self createButtonWithTitle:@"UIDynamic" frame:CGRectMake(x, 200, w, h) tag:2];
    
    
    
    
    
    
}

- (void)createButtonWithTitle:(NSString *)title frame:(CGRect)rect tag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
}


- (void)clickButton:(UIButton *)button {
    
    NSInteger tag = button.tag;
    if (tag == 1) {
        
        FRSplashScreenViewController *splash = [[FRSplashScreenViewController alloc] init];
        
        [self.navigationController pushViewController:splash animated:YES];
        
    } else if (tag == 2) {
        
        FRDynamicViewController *dynamic = [[FRDynamicViewController alloc] init];
        
        [self.navigationController pushViewController:dynamic animated:YES];
        
    } else if (tag == 3) {
        
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
