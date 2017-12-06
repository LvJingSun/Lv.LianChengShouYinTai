//
//  CarAlertView.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChooseCarModel;

typedef void(^ChooseCarBlock) (ChooseCarModel *carModel);

@interface CarAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseCarBlock choosecar;

- (void)returnCar:(ChooseCarBlock)block;

- (void)showInView:(UIView *)view;

@end
