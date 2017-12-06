//
//  ChooseZhouQiView.h
//  CashierDeskIphone
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class N_CycleType;

typedef void (^ReturnZhouQi)(N_CycleType *type);

@interface ChooseZhouQiView : UIView

@property (nonatomic, copy) ReturnZhouQi zhouqi;

- (void)ReturnZhouQi:(ReturnZhouQi)block;

@end
