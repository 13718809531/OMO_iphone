//
//  MDRemoteListModel.m
//  YXKF_MD_ipad
//
//  Created by 刘卫兵 on 2018/8/17.
//  Copyright © 2018年 元新康复. All rights reserved.
//

#import "MDRemoteListModel.h"

@implementation MDRemoteListModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"remote_id":@"id"};
}

@end

@implementation MDHandleAdminModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"handle_id":@"id"};
}

@end

@implementation MDKangFuCateModel

// 类中的属性匹配特定字符串
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"cate_id":@"id"};
}

@end
