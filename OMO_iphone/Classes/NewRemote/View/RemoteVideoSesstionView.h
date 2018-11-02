//
//  RemoteVideoSesstionView.h
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/24.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelCallVideo)(void);

@interface RemoteVideoSesstionView : UIView

@property (nonatomic,copy)CancelCallVideo cancelCallVideo;//** 取消通话 */
@end
