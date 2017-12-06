//
//  Choose_CopiesFrame.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Choose_CopiesModel;

@interface Choose_CopiesFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Choose_CopiesModel *copiesmodel;

@end
