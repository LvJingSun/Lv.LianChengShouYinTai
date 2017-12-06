//
//  RedCopiesAlertView.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_CopiesModel;

typedef void(^ChooseCopiesBlock) (Choose_CopiesModel *copiesModel);

@interface RedCopiesAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseCopiesBlock choosecopies;

- (void)returnStaff:(ChooseCopiesBlock)block;

- (void)showInView:(UIView *)view;

@end
