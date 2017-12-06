//
//  NotificationData.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "NotificationData.h"

@implementation NotificationData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSArray *)noticeList{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
   
    NSArray *items = [mDictionary getArray:@"noticeList"];
        
    for (NSDictionary *dic in items) {
       
        NoticeData *item = [[NoticeData alloc] initWithJsonObject:dic];
       
        [retArray addObject:item];

    }
    
    return retArray;

}

@end


@implementation NoticeData

- (NSString *)NoticeId{
    
    return [mDictionary objectForKey:@"NoticeId"];
    
}

- (NSString *)Title{
    
    return [mDictionary objectForKey:@"Title"];
    
}

- (NSString *)ModifyDate{
    
    return [mDictionary objectForKey:@"ModifyDate"];
    
}



@end


@implementation NoticeDetailData

- (NSString *)msg{
    
    return [mDictionary objectForKey:@"msg"];
    
}

- (NSString *)status{
    
    return [mDictionary objectForKey:@"status"];
    
}

- (NSString *)NoticeId{
    
    return [[mDictionary getDictionary:@"noticeDetail"] objectForKey:@"NoticeId"];
    
}

- (NSString *)Title{
    
    return [[mDictionary getDictionary:@"noticeDetail"] objectForKey:@"Title"];
    
}

- (NSString *)CoreIntro{
    
    return [[mDictionary getDictionary:@"noticeDetail"] objectForKey:@"CoreIntro"];
    
}

- (NSString *)Content{
    
    return [[mDictionary getDictionary:@"noticeDetail"] objectForKey:@"Content"];
    
}
- (NSString *)ModifyDate{
    
    return [[mDictionary getDictionary:@"noticeDetail"] objectForKey:@"ModifyDate"];
    
}


@end