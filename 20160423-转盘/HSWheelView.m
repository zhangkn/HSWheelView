//
//  HSWheelView.m
//  20160423-转盘
//
//  Created by devzkn on 4/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HSWheelView.h"
#import "HSWheelButton.h"
#define angle2Radian(x) ((x)/180*M_PI)
#define KHSPerButtonAngle 30

@interface HSWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *roattionImageView;
@property (nonatomic,strong) UIButton *selectedBtn;//记录现在的按钮

@end

@implementation HSWheelView
#pragma mark - 创建对象的类方法
+ (instancetype)wheelViewWithTableView:(UIView *)view{
    HSWheelView *wheelView = [[[NSBundle mainBundle] loadNibNamed:@"HSWheelView" owner:nil options:nil]lastObject];
    [view addSubview:wheelView];
    return wheelView;                 
}

#pragma mark - 添加button
- (void)awakeFromNib{
    [self.roattionImageView setUserInteractionEnabled:YES];//传递点击事件给子控件btn
    //裁剪的大图片
    UIImage *imageForNormal = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *imageForPressed = [UIImage imageNamed:@"LuckyAstrologyPressed"];

    //将点转换为像素点
    /*
     For standard-resolution displays, the scale factor is 1.0 and one point equals one pixel. For Retina displays, the scale factor is 2.0 and one point is represented by four pixels.
     */
    CGFloat margin = imageForNormal.size.width/12.0*[UIScreen mainScreen].scale ;//小图片的宽度
    CGFloat imageHeight = imageForNormal.size.height*[UIScreen mainScreen].scale ;//小图片的高度
    
    for (int i = 0; i<12; i++) {
         HSWheelButton *btn = [HSWheelButton buttonWithType:UIButtonTypeCustom];
        CGFloat rotationViewWidth = self.bounds.size.width;
        CGFloat rotationViewHeight = self.bounds.size.height;
        [btn.layer setAnchorPoint:CGPointMake(0.5, 1)];//锚点
        [btn.layer setPosition:CGPointMake(rotationViewWidth*0.5, rotationViewHeight*0.5)];//在父层的位置
        //进行旋转
        CGFloat angle =i*KHSPerButtonAngle;
        [btn.layer setTransform:CATransform3DMakeRotation(angle2Radian(angle), 0, 0, 1)];
        [btn setBounds:CGRectMake(0, 0, 68, 143)];
        //1.选中状态需要自己管理
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //2.设置正常状态的背景图片
        CGFloat x = i*margin;
        CGRect clipRect= CGRectMake(x, 0, margin,imageHeight);//裁剪的尺寸
        /**
         image
         The image to extract the subimage from. 像素点
         rect
         A rectangle whose coordinates specify the area to create an image from. 点
         
         */
        CGImageRef smallImageRef = CGImageCreateWithImageInRect(imageForNormal.CGImage, clipRect);
        [btn setImage:[UIImage imageWithCGImage:smallImageRef] forState:UIControlStateNormal];
        //设置选中的背景图片
        CGImageRef smallSelectedImageRef = CGImageCreateWithImageInRect(imageForPressed.CGImage, clipRect);
        [btn setImage:[UIImage imageWithCGImage:smallSelectedImageRef] forState:UIControlStateSelected];

        [self.roattionImageView addSubview:btn];
    }
}
- (void)btnClick:(UIButton*)btn{
    [self.selectedBtn setSelected:NO];//将上一个选择按钮去除选择
    [btn setSelected:!btn.selected];
    [self setSelectedBtn:btn];
}
                                                                                                      
                                                                                                      
                                                                                                      
                                                                                                      
@end
