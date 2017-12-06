//
//  ChooseCuXiaoYuan.h
//  CashierDeskIphone
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCuXiao)(NSString *cuxiao, NSString *cuxiaoID);

@interface ChooseCuXiaoYuan : UIView

@property (nonatomic, copy) ReturnCuXiao cuxiaoyuan;

- (void)ReturnCuXiao:(ReturnCuXiao)block;

@end
