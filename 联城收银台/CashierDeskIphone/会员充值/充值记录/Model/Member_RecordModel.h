//
//  Member_RecordModel.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member_RecordModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *TransactionType;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Member_RecordModelWithDict:(NSDictionary *)dic;

@end
