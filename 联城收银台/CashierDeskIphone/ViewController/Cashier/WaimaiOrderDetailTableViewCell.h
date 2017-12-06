//
//  WaimaiOrderDetailTableViewCell.h
//  CashierDeskIphone
//
//  Created by mac on 15-9-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaimaiOrderDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_num;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_yaoqiu;

@end

@interface WaimaiOrderDetailTableViewCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

@property (weak, nonatomic) IBOutlet UIButton *m_phoneBtn;

@end

@interface WaimaiOrderDetailTableViewCell2 : UITableViewCell
//配送
@property (weak, nonatomic) IBOutlet UIButton *m_willpeisong;
//退回
@property (weak, nonatomic) IBOutlet UIButton *m_backpeisong;
//完成配送
@property (weak, nonatomic) IBOutlet UIButton *m_overpeisong;


@end