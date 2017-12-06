//
//  Member_RecordFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Member_RecordModel;

@interface Member_RecordFrame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Member_RecordModel *recordModel;

@end
