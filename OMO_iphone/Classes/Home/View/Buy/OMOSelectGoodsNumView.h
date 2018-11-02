//
//  OMOSelectGoodsNumView.h
//  OMO_iphone
//
//  Created by wy on 2018/10/10.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMOSelectGoodsDelegate <NSObject>

- (void)omo_selectGoodsNumberOftext:(NSString *)text;

@end

@interface OMOSelectGoodsNumView : UIView

@property (nonatomic,weak)id <OMOSelectGoodsDelegate> delegate;
@property (nonatomic,assign)NSInteger minNum;// 最小值
@property (nonatomic,assign)NSInteger maxNum;// 最大值

@end
