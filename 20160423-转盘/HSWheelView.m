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
#define KButtonCount 12.0


@interface HSWheelView ()

@property (weak, nonatomic) IBOutlet UIImageView *roattionImageView;
@property (nonatomic,strong) UIButton *selectedBtn;//记录现在的按钮
@property (nonatomic,strong) CADisplayLink *link;

@end

@implementation HSWheelView

- (CADisplayLink *)link{
    if (nil == _link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}
#pragma mark - 创建对象的类方法
+ (instancetype)wheelViewWithTableView:(UIView *)view{
    HSWheelView *wheelView = [[[NSBundle mainBundle] loadNibNamed:@"HSWheelView" owner:nil options:nil]lastObject];
    [view addSubview:wheelView];
    return wheelView;                 
}

#pragma mark - 添加button
- (void)awakeFromNib{
    [self.roattionImageView setUserInteractionEnabled:YES];//传递点击事件给子控件btn
    //裁剪的大图片名称
    NSString *imageForNormalName = @"LuckyAstrology";
    NSString *imageForSelectedName = @"LuckyAstrologyPressed";
    for (int i = 0; i<KButtonCount; i++) {
        //创建button
         HSWheelButton *btn = [HSWheelButton buttonWithType:UIButtonTypeCustom];
//        [btn setAdjustsImageWhenHighlighted:NO];// whether the image changes when the button is highlighted.
        //0、进行旋转,立马想到setAnchorPoint
        CGFloat rotationViewWidth = self.bounds.size.width;
        CGFloat rotationViewHeight = self.bounds.size.height;
        [btn.layer setAnchorPoint:CGPointMake(0.5, 1)];//锚点
        [btn.layer setPosition:CGPointMake(rotationViewWidth*0.5, rotationViewHeight*0.5)];//在父层的位置
        CGFloat angle =i*KHSPerButtonAngle;
        [btn.layer setTransform:CATransform3DMakeRotation(angle2Radian(angle), 0, 0, 1)];
        [btn setBounds:CGRectMake(0, 0, 68, 143)];
        //1. 设置选中按钮时的背景图片-－选中状态需要自己管理
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //2.设置正常状态的背景图片
        [btn setImage:[self clipImageWithName:imageForNormalName index:i count:KButtonCount] forState:UIControlStateNormal];
        //设置选中的背景图片
        [btn setImage:[self clipImageWithName:imageForSelectedName index:i count:KButtonCount] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

        [self.roattionImageView addSubview:btn];
        if (i == 0) {//设置默认选中第一个按钮
            [self btnClick:btn];
        }
    }
}
#pragma mark - 管理图片的选中状态
- (void)btnClick:(UIButton*)btn{
    [self.selectedBtn setSelected:NO];//将上一个选择按钮去除选择
    [btn setSelected:!btn.selected];
    [self setSelectedBtn:btn];
}

#pragma  mark - 按钮的图片裁剪

/**
 裁剪的图片名称 name
 裁剪第几个小图片 index
 大图片的小图片个数 count
 
 */

- (UIImage*) clipImageWithName:(NSString*)name index:(int)i count:(float)count{
    //裁剪的大图片
    UIImage *bigImage = [UIImage imageNamed:name];
    //设置裁剪的尺寸
    CGFloat scale =[UIScreen mainScreen].scale;
    //将点转换为像素点
    /*
     For standard-resolution displays, the scale factor is 1.0 and one point equals one pixel. For Retina displays, the scale factor is 2.0 and one point is represented by four pixels.
     */
    CGFloat smallImageWidth = bigImage.size.width/count*scale;
    CGFloat smallImageHeight = bigImage.size.height*scale;
    CGFloat smallImageX = i*smallImageWidth;
    
    CGRect clipRect =  CGRectMake(smallImageX, 0, smallImageWidth, smallImageHeight);
    CGImageRef smallImageRef = CGImageCreateWithImageInRect(bigImage.CGImage, clipRect);
    return [UIImage imageWithCGImage:smallImageRef];
}

#pragma mark - 图片的按钮进行选择
- (void)startRotating{
    [self.link setPaused:NO];
    
}

- (void) update{
    [self.roattionImageView setTransform:CGAffineTransformRotate(self.roattionImageView.transform, angle2Radian(45/60.0))];//60 次转45弧度，每次转45/60 弧度
    
}

- (void) stopRotating{
    [self.link setPaused:YES];
    
}
#pragma  mark - 快速旋转
- (IBAction)chooseNO:(UIButton *)sender {
    //3、快点旋转
    /** 核心动画的缺点是改变不了真是的属性*/
    CABasicAnimation *animation = [CABasicAnimation animation];
    //设置动画对象属性
    [animation setKeyPath:@"transform.rotation"];
    [animation setToValue:@(M_PI*3)];
    [animation setDuration:0.5];
    [animation setDelegate:self];
    [self.roattionImageView.layer addAnimation:animation forKey:nil];
    
}

- (void)animationDidStart:(CAAnimation *)anim{
    //1.不与用户进行交互
    [self.roattionImageView setUserInteractionEnabled:NO];
    // 2、 停止慢速的旋转
    [self stopRotating];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.roattionImageView setUserInteractionEnabled:YES];
    //让选中按钮回到转盘的最上面位置
    CGFloat angle = atan2(self.selectedBtn.transform.b, self.selectedBtn.transform.a);
    [self.roattionImageView setTransform:CGAffineTransformMakeRotation(-angle)];//反转现在的角度，回到正中间
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
   
    
}

                                                                                                      
@end
