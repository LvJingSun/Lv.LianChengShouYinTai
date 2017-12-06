//
//  RefreshData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "RefreshData.h"

@implementation RefreshData
- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSString *)DayReceivablesCount{
        
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"DayReceivablesCount"];
}

- (NSString *)DayReceivablesMoney{
    
    
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"DayReceivablesMoney"];
}

- (NSString *)WeekReceivablesMoney{
        
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"WeekReceivablesMoney"];
}

- (NSString *)WorkReceivablesCount{
        
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"WorkReceivablesCount"];
}

- (NSString *)MonthReceivablesCount{
    
    
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"MonthReceivablesCount"];
}

- (NSString *)MonthReceivablesMoney{
        
    return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"MonthReceivablesMoney"];
}

- (NSString *)StatisticalDate{
    
      return [[mDictionary getDictionary:@"cashStatistics"] objectForKey:@"StatisticalDate"];
}


@end
