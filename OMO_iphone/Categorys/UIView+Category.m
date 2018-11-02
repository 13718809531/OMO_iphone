//
//  UIView+Category.m
//  YXKF_ipad
//
//  Created by wy on 2018/7/18.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (CGSize)lwb_size
{
    return self.frame.size;
}
- (void)setLwb_size:(CGSize)lwb_size
{
    CGRect frame = self.frame;
    frame.size = lwb_size;
    self.frame = frame;
}

- (CGFloat)lwb_width
{
    return self.frame.size.width;
}

- (CGFloat)lwb_height
{
    return self.frame.size.height;
}

- (void)setLwb_width:(CGFloat)lwb_width
{
    CGRect frame = self.frame;
    frame.size.width = lwb_width;
    self.frame = frame;
}

- (void)setLwb_height:(CGFloat)lwb_height
{
    CGRect frame = self.frame;
    frame.size.height = lwb_height;
    self.frame = frame;
}

- (CGFloat)lwb_x
{
    return self.frame.origin.x;
}

- (void)setLwb_x:(CGFloat)lwb_x
{
    CGRect frame = self.frame;
    frame.origin.x = lwb_x;
    self.frame = frame;
}

- (CGFloat)lwb_y
{
    return self.frame.origin.y;
}

- (void)setLwb_y:(CGFloat)lwb_y
{
    CGRect frame = self.frame;
    frame.origin.y = lwb_y;
    self.frame = frame;
}

- (CGFloat)lwb_centerX
{
    return self.center.x;
}

- (void)setLwb_centerX:(CGFloat)lwb_centerX
{
    CGPoint center = self.center;
    center.x = lwb_centerX;
    self.center = center;
}

- (CGFloat)lwb_centerY
{
    return self.center.y;
}

- (void)setLwb_centerY:(CGFloat)lwb_centerY
{
    CGPoint center = self.center;
    center.y = lwb_centerY;
    self.center = center;
}

- (CGFloat)lwb_right
{
    CGFloat r = self.lwb_x + self.lwb_width;
    return r;
//    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lwb_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setLwb_right:(CGFloat)lwb_right
{
    self.lwb_x = lwb_right - self.lwb_width;
}

- (void)setLwb_bottom:(CGFloat)lwb_bottom
{
    self.lwb_y = lwb_bottom - self.lwb_height;
}

- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}
-(void)cornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = (radius==0)?NO:YES;
}

@end
