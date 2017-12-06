//
//  Choose_FenShuFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Choose_FenShuModel;

@interface Choose_FenShuFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Choose_FenShuModel *fenshumodel;

@end
