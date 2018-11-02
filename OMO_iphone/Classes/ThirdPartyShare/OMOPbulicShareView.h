//
//  OMOPbulicShareView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMOShareModel.h"

typedef void(^ShareBlock)(BOOL success);

@interface OMOPbulicShareView : UIView

/**  */
@property (nonatomic, strong)OMOShareModel *shareModel;

/**  */
@property (nonatomic,copy)ShareBlock shareBlock;

- (void)show;
- (void)dissMiss;

@end
