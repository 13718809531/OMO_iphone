//
//  OMODeviceDescView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOKangFuBaoMtItemModel.h"

@interface OMODeviceDescView : UIView

/**  */
@property (nonatomic, strong)OMOKangFuBaoMtItemModel *itemModel;

- (void)show;
- (void)dissMiss;

@end
