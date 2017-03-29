//
//  UIThreadCrashViewController.m
//  NeverCrashDemo
//
//  Created by knewcloud on 2017/3/28.
//  Copyright © 2017年 jseanj. All rights reserved.
//

#import "UIThreadCrashViewController.h"

@interface UIThreadCrashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation UIThreadCrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //self.label.text = @"test";
    });
}

- (IBAction)btnTapped:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.label.text = @"test";
    });
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
