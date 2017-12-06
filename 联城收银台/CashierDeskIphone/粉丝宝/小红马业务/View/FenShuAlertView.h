//
//  FenShuAlertView.h
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Choose_FenShuModel;

typedef void(^ChooseFenshuBlock) (Choose_FenShuModel *fenshuModel);

@interface FenShuAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseFenshuBlock choosefenshu;

- (void)returnFenShu:(ChooseFenshuBlock)block;

- (void)showInView:(UIView *)view;

@end
