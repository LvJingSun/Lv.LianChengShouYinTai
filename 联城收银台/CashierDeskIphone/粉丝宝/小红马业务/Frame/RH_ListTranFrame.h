//
//  RH_ListTranFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_ListTranModel;

@interface RH_ListTranFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect productF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_ListTranModel *listModel;

@end
