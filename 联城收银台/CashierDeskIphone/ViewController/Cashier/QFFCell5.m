//
//  QFFCell5.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFCell5.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 20, SCREEN_WIDTH * 0.9, 40)];
        
        self.sureBtn = btn;
        
        [btn setTitle:@"确认赠送" forState:UIControlStateNormal];
        
        [btn setBackgroundColor:[UIColor colorWithRed:189/255. green:27/255. blue:9/255. alpha:1.]];
        
        btn.layer.cornerRadius = 3;
        
        [self addSubview:btn];
        
        self.height = CGRectGetMaxY(btn.frame) + 20;
        
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
