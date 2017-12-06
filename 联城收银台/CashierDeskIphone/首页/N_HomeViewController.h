//
//  N_HomeViewController.h
//  CashierDeskIphone
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface N_HomeViewController : UIViewController

// 记录是key值的还是手机号码的二维码扫描 1为key值  2为手机号码 3,会员卡信息
@property(nonatomic, assign) int m_scanIndex;

// 记录二维码的扫描结果字符
@property (nonatomic, strong) NSString       *m_ScanString;

@end
