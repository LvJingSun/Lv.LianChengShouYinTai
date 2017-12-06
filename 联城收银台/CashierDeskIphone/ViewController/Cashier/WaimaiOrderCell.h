//
//  WaimaiOrderCell.h
//  CashierDeskIphone
//
//  Created by mac on 15-8-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaimaiOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *PriceAmount;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

- (void)SetValueWaimaiOrder:(NSDictionary*)DIC;

@end



@interface WaimaiMenuDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_menuName;

@property (weak, nonatomic) IBOutlet UILabel *m_amount;

@property (weak, nonatomic) IBOutlet UILabel *m_zidingyiRule;

@end