//
//  OMOPayTypeCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/17.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OMOPayTypeDefault = 0,// 微信
    OMOPayTypeWeiXin = -1,// 微信
    OMOPayTypeAliPay = 1,// 支付宝
} OMOPayType;

@interface OMOPayTypeCell : UITableViewCell

/**  */
@property (nonatomic,assign)OMOPayType payType;

/**  */
@property (nonatomic,assign)BOOL isSelect;

@end
