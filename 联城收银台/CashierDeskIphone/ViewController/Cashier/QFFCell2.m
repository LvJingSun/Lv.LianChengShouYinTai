//
//  QFFCell2.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFCell2.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 10, SCREEN_WIDTH * 0.9, 50)];
        
        self.phoneField = phoneField;
        
        phoneField.backgroundColor = [UIColor whiteColor];
        
        phoneField.placeholder = @"请输入手机号";
        
        phoneField.font = [UIFont systemFontOfSize:22];
        
        phoneField.keyboardType = UIKeyboardTypeNumberPad;
        
        phoneField.layer.cornerRadius = 5;
        
        phoneField.layer.borderWidth = 0.5;
        
        phoneField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        icon.image = [UIImage imageNamed:@"icon_account.png"];
        
        phoneField.leftView = icon;
        
        phoneField.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:phoneField];
        
        self.height = CGRectGetMaxY(phoneField.frame) + 10;
        
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
