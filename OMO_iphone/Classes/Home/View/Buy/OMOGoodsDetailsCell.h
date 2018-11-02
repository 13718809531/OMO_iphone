//
//  OMOGoodsDetailsCell.h
//  OMO_iphone
//
//  Created by wy on 2018/10/9.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  */
#import "OMOKangFuBaoMtItemModel.h"

/**
 *
 *
 */
@protocol OMOGoodsBuyDelegate <NSObject>

- (void)omo_goodsBuyWithGoodsId:(NSString *)goodsId Select:(BOOL)isSelect;
- (void)omo_goodsBuyWithGoodsId:(NSString *)goodsId GoodsNum:(NSInteger)goodsNum;

@end

@interface OMOGoodsDetailsCell : UITableViewCell

/**  */
@property (nonatomic , weak) id <OMOGoodsBuyDelegate> delegate; 
/**  */
@property (nonatomic, strong)OMOKangFuBaoMtItemModel *itemModel;

@end
