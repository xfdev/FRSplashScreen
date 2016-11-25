//
//  ViewController.m
//  FRSplashScreen
//
//  Created by sonny on 16/11/25.
//  Copyright © 2016年 github.com/xfdev. All rights reserved.
//

#import "ViewController.h"

#import "FRSplashScreenViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 200, 300, 300);
    button.center = self.view.center;
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    
}

- (void)clickButton:(UIButton *)button {
    
    FRSplashScreenViewController *splash = [[FRSplashScreenViewController alloc] init];
    
    [self.navigationController pushViewController:splash animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
