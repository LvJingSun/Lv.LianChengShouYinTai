//
//  WaimaiOrderCell.m
//  CashierDeskIphone
//
//  Created by mac on 15-8-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "WaimaiOrderCell.h"

@implementation WaimaiOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)SetValueWaimaiOrder:(NSDictionary*)DIC{

    self.m_name.text = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"LinkName"]];
    self.m_phone.text = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"LinkPhone"]];
    self.m_time.text = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"PeiSongTime"]];
    self.m_address.text = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"Address"]];
    self.PriceAmount.text = [NSString stringWithFormat:@"￥%@",[DIC objectForKey:@"PriceAmount"]];
    
    NSInteger status =[[NSString stringWithFormat:@"%@",[DIC objectForKey:@"Status"]] integerValue];
    switch (status) {
        case 0:
            self.m_status.text = @"待配送";
            [self.m_status setTextColor:RGBA(62, 169, 24, 1)];
            break;
        case 1:
            self.m_status.text = @"配送中";
            [self.m_status setTextColor:RGBA(86, 167, 241, 1)];

            break;
        case 2:
            self.m_status.text = @"已配送";
            [self.m_status setTextColor:RGBA(86, 167, 241, 1)];

            break;
        case 3:
            self.m_status.text = @"已退回";
            [self.m_status setTextColor:RGBA(250, 38, 74, 1)];


            break;
        default:
            break;
    }
    
}


@end



@implementation WaimaiMenuDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end