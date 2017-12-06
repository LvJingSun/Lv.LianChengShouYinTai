//
//  QFFCell1.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFCell1.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH * 0.5, 30)];
        
        title.text = @"余额：";
        
        title.textAlignment = NSTextAlignmentRight;
        
        title.font = [UIFont systemFontOfSize:22];
        
        [self addSubview:title];
        
        UILabel *yueLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 10, SCREEN_WIDTH * 0.5, 30)];
        
        self.countLab = yueLab;
        
        yueLab.text = @"0.00";
        
        yueLab.textAlignment = NSTextAlignmentLeft;
        
        yueLab.font = [UIFont systemFontOfSize:22];
        
        yueLab.textColor = [UIColor redColor];
        
        [self addSubview:yueLab];
        
        self.height = CGRectGetMaxY(yueLab.frame) + 10;
        
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
