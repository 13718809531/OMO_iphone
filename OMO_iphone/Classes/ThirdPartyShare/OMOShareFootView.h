//
//  OMOShareFootView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClooseBlock)(void);

@interface OMOShareFootView : UICollectionReusableView

/** 关闭 */
@property (nonatomic,copy)ClooseBlock clooseBlock;

@end
