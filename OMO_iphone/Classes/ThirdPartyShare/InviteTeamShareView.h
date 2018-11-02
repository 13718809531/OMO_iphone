//
//  InviteTeamShareView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WTShareContentItem.h"

typedef void(^inviteTeamShareViewBlock)(void);

@interface InviteTeamShareView : UIView

-(void)show;
-(void)dissMiss;

@property (nonatomic,strong)NSArray * iconArray;
@property (nonatomic,strong)NSArray * titleArray;

/**分享模型对象*/
@property (nonatomic,strong)WTShareContentItem * shareItem;
@property (nonatomic,copy)inviteTeamShareViewBlock creatPosterBlock;//生成海报Block
@property (nonatomic,copy)inviteTeamShareViewBlock copyPathBlock;//复制链接Block
@property (nonatomic,copy)inviteTeamShareViewBlock cancelBlock;//取消显示的Block，为了控制器的海报图片更改

@end
