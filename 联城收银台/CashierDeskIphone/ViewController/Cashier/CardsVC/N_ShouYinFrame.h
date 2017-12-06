//
//  N_ShouYinFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class N_ShouYinModel;

@interface N_ShouYinFrame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) N_ShouYinModel *recordModel;

@end
