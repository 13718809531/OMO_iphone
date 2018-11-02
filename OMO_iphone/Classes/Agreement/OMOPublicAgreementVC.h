//
//  OMOPublicAgreementVC.h
//  OMO_iphone
//
//  Created by wy on 2018/10/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    OMOAgreementTypeService = 1,// 服务协议
    OMOAgreementTypeRegistered = 2,// 注册协议
    OMOAgreementTypeLiability = 3,// 免责
    OMOAgreementTypeAboutUs = 4// 关于我们
} OMOAgreementType;

@interface OMOPublicAgreementVC : BaseViewController

/**  */
@property (nonatomic,assign)OMOAgreementType agreementType;

@end
