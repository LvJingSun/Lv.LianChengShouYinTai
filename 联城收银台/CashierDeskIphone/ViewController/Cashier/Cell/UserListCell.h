//
//  UserListCell.h
//  CashierDeskIphone
//
//  Created by CityAndCity on 15-8-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@end
