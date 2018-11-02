//
//  OMOShowWXBindingVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/22.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^WXBindingBlock)(BOOL isCancel);

@interface OMOShowWXBindingVC : BaseViewController

/**  */
@property (nonatomic,copy)WXBindingBlock WXBindingBlock;
/**  */
@property (nonatomic, strong)NSDictionary *wxUserInfo;

@end
