//
//  OMORemoteBookingDateModel.m
//  OMO_iphone
//
//  Created by wy on 2018/10/24.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteWeekModel.h"

@implementation OMORemoteWeekModel

- (NSString *)weekStr{
    
    if(_weekStr == nil){
        
        _weekStr = [self getWeekDay:self.dateStr];
    }
    return _weekStr;
}
- (NSInteger)weekIndex{
    
    //创建一个星期数组
    NSArray *weekday = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSInteger index = [weekday indexOfObject:self.weekStr];
    
    return index;
}
- (NSString *)getWeekDay:(NSString *)timeStr {
    //创建一个星期数组
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc]init];
    [dateFmt setDateFormat:@"yyyy-MM-dd"];
    //将时间戳转换成日期
    NSDate *newDate = [dateFmt dateFromString:timeStr];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
@end
