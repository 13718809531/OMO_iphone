//
//  OMOClearCacheAlertView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClearCacheBlock)(void);

@interface OMOClearCacheAlertView : UIView

/**  */
@property (nonatomic,copy)ClearCacheBlock clearCacheBlock;
- (void)show;
- (void)dissMiss;

@end
