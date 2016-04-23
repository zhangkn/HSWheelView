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
@property (nonatomic,weak) HSWheelView *wheelView;

@end

@implementation ViewController

- (HSWheelView *)wheelView{
    if (nil == _wheelView) {
        HSWheelView *tmpView = [HSWheelView wheelViewWithTableView:self.view];
        _wheelView = tmpView;
    }
    return _wheelView;
}
- (IBAction)startRotating:(id)sender {
    [self.wheelView startRotating];
    
}
- (IBAction)stopRotating:(id)sender {
    [self.wheelView stopRotating];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wheelView setCenter:self.view.center];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
