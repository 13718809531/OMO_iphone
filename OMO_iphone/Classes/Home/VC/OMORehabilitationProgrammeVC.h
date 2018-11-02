//
//  OMORehabilitationProgrammeVC.h
//  OMO_iphone
//
//  Created by wy on 2018/9/29.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"
/**  */
#import "OMOKangFuBaoModel.h"

/** 康复训练计划 */
@interface OMORehabilitationProgrammeVC : BaseViewController

/** 记录是首次进入还是再次进入 */
@property (nonatomic,assign)NSInteger numType;
/**  */
@property (nonatomic, strong)OMOKangFuBaoModel *kangFuBaoModel;

@end
