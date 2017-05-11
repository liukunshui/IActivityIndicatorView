//
//  ViewController.m
//  IActivityIndicatorView
//
//  Created by ZCapple on 2017/5/11.
//  Copyright © 2017年 1234. All rights reserved.
//

#import "ViewController.h"
#import "IActivityIndicatorView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = CGRectMake(100, 200, 200, 50);
    [bu setTitle:@"Show" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(Show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    
    
    UIButton *bu1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bu1.frame = CGRectMake(100, 300, 200, 50);
    [bu1 setTitle:@"Hide" forState:UIControlStateNormal];
    [bu1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bu1 addTarget:self action:@selector(Hide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu1];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)Show{
    net_activity_indicator_start();
}
-(void)Hide{
    net_activity_indicator_stop();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
