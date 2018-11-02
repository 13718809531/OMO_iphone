//
//  OMOAssessmentPayAlertView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/16.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOKangFuBaoModel.h"

@interface OMOAssessmentPayAlertView : UIView

/**  */
@property (nonatomic, strong)OMOKangFuBaoModel *kangFuBaoModel;

/**  */
@property (nonatomic,assign)NSInteger numType;

- (void)show;
- (void)dissMiss;

@end
