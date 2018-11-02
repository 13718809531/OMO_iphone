//
//  OMOCustomTwoTitleButton.h
//  OMO_iphone
//
//  Created by 刘卫兵 on 2018/9/7.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMOCustomTwoTitleButton : UIButton

@property(strong,nonatomic)UILabel *leftTitleLab;// 左侧lab
@property(strong,nonatomic)UILabel *rightTitleLab;// 右侧lab
@property(strong,nonatomic)UIImageView *arrowImg;// 标示img
@property (nonatomic,copy)NSString *leftTitle;//** 左侧文字 */
@property (nonatomic,copy)NSString *rightTitle;//** 右侧文字 */

@end
