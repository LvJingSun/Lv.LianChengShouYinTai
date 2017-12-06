//
//  N_chongzhiCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_chongzhiCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation N_chongzhiCell

+ (instancetype)N_chongzhiCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"N_chongzhiCell";
    
    N_chongzhiCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_chongzhiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 10, SCREEN_WIDTH * 0.8, 45)];
        
        self.button = button;
        
        [button setBackgroundImage:[UIImage imageNamed:@"button_confirm.png"] forState:0];
        
        button.layer.masksToBounds = YES;
        
        button.layer.cornerRadius = 5;
        
        [self addSubview:button];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame) + 5, SCREEN_WIDTH, 15)];
        
        lab.text = @"会员出示卡号或二维码进行充值";
        
        lab.font = [UIFont systemFontOfSize:14];
        
        lab.textColor = [UIColor lightGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        
        self.height = CGRectGetMaxY(lab.frame) + 5;
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
