//
//  ViewController.m
//  20160423-转盘
//
//  Created by devzkn on 4/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "ViewController.h"
#import "HSWheelView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HSWheelView *wheelView = [HSWheelView wheelViewWithTableView:self.view];
    [wheelView setCenter:self.view.center];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
