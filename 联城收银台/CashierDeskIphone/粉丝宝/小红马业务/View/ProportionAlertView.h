//
//  ProportionAlertView.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_ProportionModel;

typedef void(^ChooseProportionBlock) (Choose_ProportionModel *proportionModel);

@interface ProportionAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseProportionBlock chooseproportion;

- (void)returnProportion:(ChooseProportionBlock)block;

- (void)showInView:(UIView *)view;

@end
