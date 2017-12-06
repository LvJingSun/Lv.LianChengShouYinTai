//
//  WaimaiOrderViewController.h
//  CashierDeskIphone
//
//  Created by mac on 15-8-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  外卖订单的页面

#import "BaseViewController.h"

@interface WaimaiOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray    *m_orderList;

@property (weak, nonatomic) IBOutlet UIButton *waitDeliverBtn;
@property (weak, nonatomic) IBOutlet UIButton *delivery;
@property (weak, nonatomic) IBOutlet UIButton *finishDelivery;
@property (weak, nonatomic) IBOutlet UIButton *sendBackBtn;
@property (weak, nonatomic) IBOutlet UILabel *simpleLable;//暂无相关数据


/*<form method="post" action="CashierDesk/MyWaiMaiOrder.ashx">
<h2>【2015-08-07启用】</h2>
<h2>收银员外卖订单列表</h2>
收银ID（是）：<input name="CashierAccountID" type="text" value="1" /><br />
验证key：<input name="Key" type="text" value="10" /><br />
外卖订单状态（0，待确认配送，1，待配送2，已配送完成3，已退回）：<input name="Status" type="text" value="" /><br />
<input id="Submit36" type="submit" value="submit" />
</form> */
- (IBAction)btnClick:(id)sender;

// 判断是否是展开还是闭合的集合
@property (nonatomic, strong) NSMutableSet          *m_SectionsSet;

@end
