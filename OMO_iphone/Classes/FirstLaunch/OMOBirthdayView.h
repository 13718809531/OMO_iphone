//
//  OMOBirthdayView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetBirthdayBlock)(void);

@interface OMOBirthdayView : UIView

/**  */
@property (nonatomic,copy)SetBirthdayBlock birthdayBlock;
@end
