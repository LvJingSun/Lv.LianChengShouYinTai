//
//  SureSoleCell.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-12.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SureSoleCell.h"

@implementation SureSoleCell

@synthesize m_btn;

@synthesize m_phoneLabel;

@synthesize m_priceLabel;

@synthesize suringLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
