//
//  StaffAlertView.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_StaffModel;

typedef void(^ChooseStaffBlock) (Choose_StaffModel *staffModel);

@interface StaffAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseStaffBlock choosestaff;

- (void)returnStaff:(ChooseStaffBlock)block;

- (void)showInView:(UIView *)view;

@end
