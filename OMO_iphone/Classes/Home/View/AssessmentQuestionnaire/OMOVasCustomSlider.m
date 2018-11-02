//
//  OMOVasCustomSlider.m
//  OMO_iphone
//
//  Created by wy on 2018/9/28.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOVasCustomSlider.h"

@implementation OMOVasCustomSlider

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        
    }
    return self;
}
- (CGRect)trackRectForBounds:(CGRect)bounds {
    
    return CGRectMake(0, 0, bounds.size.width, 20);
}

@end
