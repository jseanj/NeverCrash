//
//  SelectorCrashViewController.m
//  NeverCrashDemo
//
//  Created by knewcloud on 2017/3/28.
//  Copyright © 2017年 jseanj. All rights reserved.
//

#import "SelectorCrashViewController.h"

@interface SelectorCrashViewController ()

@end

@implementation SelectorCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(@"test")];
#pragma clang diagnostic pop
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
