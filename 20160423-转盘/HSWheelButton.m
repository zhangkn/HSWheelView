//
//  HSWheelButton.m
//  20160423-转盘
//
//  Created by devzkn on 4/23/16.
//  Copyright © 2016 hisun. All rights reserved.
//

#import "HSWheelButton.h"

@implementation HSWheelButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
 Returns the rectangle in which the receiver draws its image.
 The rectangle in which the receiver draws its image.
 origin = (x = 0, y = 0), size = (width = 68, height = 143))
 */

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 47;
    CGFloat x = (contentRect.size.width- imageWidth)*0.5;
//    CGFloat y = (contentRect.size.height-imageHeight)*0.5;
    CGFloat y =20;
    return CGRectMake(x, y, imageWidth, imageHeight);
}

@end
