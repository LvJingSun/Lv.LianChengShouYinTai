//
//  FSB_ListFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_ListModel;

@interface FSB_ListFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect productF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) FSB_ListModel *listModel;

@end
