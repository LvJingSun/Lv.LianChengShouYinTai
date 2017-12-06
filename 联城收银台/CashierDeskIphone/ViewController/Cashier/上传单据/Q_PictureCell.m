//
//  Q_PictureCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Q_PictureCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//线的颜色
#define LineColor [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.]
//导航栏颜色
#define NAVColor [UIColor colorWithRed:72/255. green:162/255. blue:245/255. alpha:1.]

@implementation Q_PictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *noticeLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 20, SCREEN_WIDTH * 0.9, 60)];
        
        noticeLab.textColor = [UIColor redColor];
        
        noticeLab.numberOfLines = 0;
        
        noticeLab.font = [UIFont systemFontOfSize:15];
        
        noticeLab.text = @"根据城与城官方规定，凡消费金额大于或等于1000元并参与全返付业务的订单，需提交销售单或发票等作为备案审查";
        
        [self addSubview:noticeLab];
        
        UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        logoBtn.frame = CGRectMake((SCREEN_WIDTH - 200) * 0.5, 20 + CGRectGetMaxY(noticeLab.frame), 200, 200);
        
        self.hetongBtn = logoBtn;
        
//        [logoBtn setImage:[[UIImage imageNamed:@"selectImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
        [logoBtn setBackgroundImage:[UIImage imageNamed:@"selectImg.png"] forState:0];
        
        logoBtn.layer.masksToBounds = YES;
        
        logoBtn.layer.cornerRadius = 5;
        
        logoBtn.layer.borderColor = LineColor.CGColor;
        
        logoBtn.layer.borderWidth = 1;
        
        [self addSubview:logoBtn];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(logoBtn.frame) + 10, SCREEN_WIDTH, 30)];
        
        lab.text = @"合同/销售单";
        
        lab.textColor = [UIColor darkGrayColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        lab.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:lab];
        
        UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        applyBtn.frame = CGRectMake((SCREEN_WIDTH - 200) * 0.5, CGRectGetMaxY(lab.frame) + 20, 200, 200);
        
        self.fapiaoBtn = applyBtn;
        
//        [applyBtn setImage:[[UIImage imageNamed:@"selectImg.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
        [applyBtn setBackgroundImage:[UIImage imageNamed:@"selectImg.png"] forState:0];
        
        applyBtn.layer.masksToBounds = YES;
        
        applyBtn.layer.cornerRadius = 5;
        
        applyBtn.layer.borderColor = LineColor.CGColor;
        
        applyBtn.layer.borderWidth = 1;
        
        [self addSubview:applyBtn];
        
        UILabel *applylab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(applyBtn.frame) + 10, SCREEN_WIDTH, 30)];
        
        applylab.text = @"收据/发票";
        
        applylab.textColor = [UIColor darkGrayColor];
        
        applylab.textAlignment = NSTextAlignmentCenter;
        
        applylab.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:applylab];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, CGRectGetMaxY(applylab.frame) + 40, SCREEN_WIDTH * 0.9, 50)];
        
        self.sureBtn = sureBtn;
        
        sureBtn.layer.cornerRadius = 5;
        
        sureBtn.backgroundColor = NAVColor;
        
        [sureBtn setTitle:@"确认赠送" forState:0];
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        [self addSubview:sureBtn];
        
        self.height = CGRectGetMaxY(sureBtn.frame) + 20;
        
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
