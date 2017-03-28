//
//  ViewController.m
//  NeverCrashDemo
//
//  Created by knewcloud on 2017/3/28.
//  Copyright © 2017年 jseanj. All rights reserved.
//

#import "ViewController.h"
#import "NeverCrashManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NeverCrashManager shared] enable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
