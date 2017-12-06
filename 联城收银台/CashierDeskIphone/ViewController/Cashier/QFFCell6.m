//
//  QFFCell6.m
//  CashierDeskIphone
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFCell6.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFCell6

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 5, SCREEN_WIDTH * 0.9, 40)];
        
        self.zhouqiField = textfield;
        
        textfield.backgroundColor = [UIColor whiteColor];
        
        textfield.font = [UIFont systemFontOfSize:18];
        
        textfield.layer.cornerRadius = 5;
        
        textfield.layer.borderWidth = 0.5;
        
//        textfield.placeholder = @"选择返利周期";
        
        textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textfield.frame.size.width * 0.3, 30)];
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        
        textfield.leftView = titleLab;
        
        textfield.leftViewMode = UITextFieldViewModeAlways;
        
        self.titleLab = titleLab;
        
//        titleLab.text = @"返利周期:";
        
        [self addSubview:textfield];
        
        UIButton *chooseBtn = [[UIButton alloc] initWithFrame:textfield.frame];
        
        self.chooseBtn = chooseBtn;
        
        [self addSubview:chooseBtn];
        
        self.height = CGRectGetMaxY(textfield.frame) + 10;
        
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
