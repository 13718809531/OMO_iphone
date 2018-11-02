//
//  MDPlayRemoteResourceView.h
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/24.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBPlayer.h"

@interface MDPlayRemoteResourceView : UIView

@property (nonatomic,copy)NSString *videoUrl;// 播放路径
@property (nonatomic,strong) SBPlayer *player;

@end
