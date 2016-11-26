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
    
    [self createButtonWithTitle:@"POP" tag:1];
    [self createButtonWithTitle:@"UIDynamic" tag:2];
    
    
    
    
    
    
}

- (void)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, (tag * 70) + 30, 120, 50);
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
