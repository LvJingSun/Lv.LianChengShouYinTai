//
//  OrderCell.h
//  CashierDeskIphone
//
//  Created by mac on 15-6-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_amount;

@end


@interface MenuOrderInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel    *m_account;

@property (weak, nonatomic) IBOutlet UILabel    *m_time;

@property (weak, nonatomic) IBOutlet UILabel    *m_personCount;

@property (weak, nonatomic) IBOutlet UIButton   *m_callBtn;


@end


@interface MEnuOrderSeatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel    *m_seatName;
@property (weak, nonatomic) IBOutlet UIButton   *m_seatBtn;

@end