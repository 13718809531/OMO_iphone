//
//  MDRemoteListModel.h
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/17.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MDMyClientModel.h"

@class MDHandleAdminModel;
@class MDKangFuCateModel;

@interface MDRemoteListModel : NSObject

@property (nonatomic,copy)NSString *remote_id;//** 远程id */
@property (nonatomic,copy)NSString *user_id;//** 顾客id */
@property (nonatomic,assign)NSInteger start_time;//** 预约开始时间 */
@property (nonatomic,assign)NSInteger end_time;//** 预约结束时间 */
@property (nonatomic,copy)NSString *week;//** 周几 */
@property (nonatomic,copy)NSString *handle_admin_id;//** 远程专家id */
@property (nonatomic,copy)NSString *assist_admin_id;//** 员工id */
@property (nonatomic,copy)NSString *cate_id;//** 部位 */
@property (nonatomic,copy)NSString *consult_question;//** 咨询的问题 */
@property (nonatomic,copy)NSString *state;//** 状态1进行中；2已完成；4已拒绝; 3已取消；默认为1 */
@property (nonatomic,copy)NSString *created;//** 预约生成时间 */
@property (nonatomic,copy)NSString *updated;//** 预约更改时间 */
@property (nonatomic,copy)NSString *type_id;//** 康复类型id */
@property (nonatomic,copy)NSString *type_name;//** 康复名称 */
@property (nonatomic,copy)NSString *store_id;//** 门店id */
@property (nonatomic,copy)NSString *ins_id;//** 机构id */
//@property(strong,nonatomic)MDMyClientModel *user;//** 用户信息 */
@property(strong,nonatomic)MDHandleAdminModel *handleAdmin;//** 专家信息 */
@property(strong,nonatomic)MDKangFuCateModel *peCate;//** 康复部位信息 */

@end

@interface MDHandleAdminModel : NSObject

@property (nonatomic,copy)NSString *handle_id;//** 专家id */
@property (nonatomic,copy)NSString *realname;//** 专家名称 */

@end

@interface MDKangFuCateModel : NSObject

@property (nonatomic,copy)NSString *cate_id;//** 部位id */
@property (nonatomic,copy)NSString *cate_name;//** 部位名称 */

@end
