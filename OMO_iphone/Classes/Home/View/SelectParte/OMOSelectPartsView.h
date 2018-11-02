//
//  OMOSelectPartsView.h
//  OMO_iphone
//
//  Created by wy on 2018/9/14.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeletPaetsblock)(NSString *selectName);

@interface OMOSelectPartsView : UIView

@property (nonatomic,copy)SeletPaetsblock seletPaetsblock;/**  */

@end
