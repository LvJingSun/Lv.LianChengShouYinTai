//
//  Member_RechargeCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Member_RechargeCell.h"
#import "FSB_Header.h"
#import "Member_RechargeModel.h"
#import "Member_RechargeFrame.h"
#import "RH_RadioView.h"
#import "UIImageView+AFNetworking.h"

@interface Member_RechargeCell ()

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UILabel *typeTitleLab;

@property (nonatomic, weak) RH_RadioView *yueView;

@property (nonatomic, weak) RH_RadioView *jifenView;

@property (nonatomic, weak) UILabel *countTitleLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UILabel *beizhuTitleLab;

@property (nonatomic, weak) UITextField *beizhuField;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation Member_RechargeCell

+ (instancetype)Member_RechargeCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Member_RechargeCell";
    
    Member_RechargeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Member_RechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = BGColor;
        
        UITextField *phonefield = [[UITextField alloc] init];
        
        self.phoneField = phonefield;
        
        phonefield.backgroundColor = [UIColor whiteColor];
        
        phonefield.placeholder = @"输入手机号";
        
        phonefield.keyboardType = UIKeyboardTypePhonePad;
        
        [self addSubview:phonefield];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bg];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *balance = [[UILabel alloc] init];
        
        self.balanceLab = balance;
        
        balance.textColor = [UIColor darkTextColor];
        
        balance.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:balance];
        
        UILabel *typetitle = [[UILabel alloc] init];
        
        self.typeTitleLab = typetitle;
        
        typetitle.textColor = [UIColor blackColor];
        
        typetitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:typetitle];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.countTitleLab = counttitle;
        
        counttitle.textColor = [UIColor blackColor];
        
        counttitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:counttitle];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.layer.masksToBounds = YES;
        
        count.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        count.layer.borderWidth = 0.5;
        
        count.layer.cornerRadius = 5;
        
        count.font = [UIFont systemFontOfSize:15];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        
        lab.backgroundColor = [UIColor whiteColor];
        
        count.leftViewMode = UITextFieldViewModeAlways;
        
        count.leftView = lab;
        
        [count addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        [self addSubview:count];
        
        UILabel *beizhutitle = [[UILabel alloc] init];
        
        self.beizhuTitleLab = beizhutitle;
        
        beizhutitle.textColor = NAVTextColor;
        
        beizhutitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:beizhutitle];
        
        UITextField *beizhu = [[UITextField alloc] init];
        
        self.beizhuField = beizhu;
        
        beizhu.layer.masksToBounds = YES;
        
        beizhu.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        beizhu.layer.borderWidth = 0.5;
        
        beizhu.layer.cornerRadius = 5;
        
        beizhu.font = [UIFont systemFontOfSize:15];
        
        UILabel *labl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        
        labl.backgroundColor = [UIColor whiteColor];
        
        beizhu.leftViewMode = UITextFieldViewModeAlways;
        
        beizhu.leftView = labl;
        
        [beizhu addTarget:self action:@selector(beizhuChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:beizhu];
        
        UIButton *sure = [[UIButton alloc] init];
        
        self.sureBtn = sure;
        
        [sure setBackgroundColor:NAVTextColor];
        
        sure.layer.masksToBounds = YES;
        
        sure.layer.cornerRadius = 5;
        
        [sure setTitleColor:[UIColor whiteColor] forState:0];
        
        [self addSubview:sure];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Member_RechargeFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)countChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

- (void)beizhuChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(BeiZhuFieldChange:)]) {
        
        [self.delegate BeiZhuFieldChange:field];
        
    }
    
}

- (void)setRect {
    
    self.phoneField.frame = self.frameModel.phoneF;
    
    UIImageView *per = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    per.image = [UIImage imageNamed:@"account"];
    
    self.phoneField.leftViewMode = UITextFieldViewModeAlways;
    
    self.phoneField.leftView = per;
    
    UIButton *saomiao = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    
    [saomiao setImage:[UIImage imageNamed:@""] forState:0];
    
    self.phoneField.rightViewMode = UITextFieldViewModeAlways;
    
    self.phoneField.rightView = saomiao;
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.iconImg.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.balanceLab.frame = self.frameModel.balanceF;
    
    self.typeTitleLab.frame = self.frameModel.typeTitleF;
    
    RH_RadioView *yue = [[RH_RadioView alloc] initWithFrame:self.frameModel.yueRechargeF];
    
    self.yueView = yue;
    
    [self addSubview:yue];
    
    RH_RadioView *jifen = [[RH_RadioView alloc] initWithFrame:self.frameModel.jifenRechargeF];
    
    self.jifenView = jifen;
    
    [self addSubview:jifen];
    
    self.countTitleLab.frame = self.frameModel.countTitleF;
    
    self.countField.frame = self.frameModel.countF;
    
    self.beizhuTitleLab.frame = self.frameModel.beizhuTitleF;
    
    self.beizhuField.frame = self.frameModel.beizhuF;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {
    
    Member_RechargeModel *model = self.frameModel.rechargeModel;
    
    if ([self isBlankString:model.phone]) {
        
        self.phoneField.text = @"";
        
    }else {
        
        self.phoneField.text = [NSString stringWithFormat:@"%@",model.phone];
        
    }
    
    
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.iconUrl]] placeholderImage:[UIImage imageNamed:@"FSB_头像.png"]];
    
    if ([self isBlankString:model.name]) {
        
        self.nameLab.text = @"";
        
    }else {
        
        self.nameLab.text = [NSString stringWithFormat:@"%@",model.name];
        
    }
    
    if ([self isBlankString:model.balance]) {
        
        self.balanceLab.text = @"";
        
    }else {
        
        if ([model.rechargeType isEqualToString:@"1"]) {
            
            self.balanceLab.text = [NSString stringWithFormat:@"会员卡余额:%@",model.balance];
            
        }else if ([model.rechargeType isEqualToString:@"2"]) {
            
            self.balanceLab.text = [NSString stringWithFormat:@"积分余额:%@",model.jifen];
            
        }
        
    }
    
    self.typeTitleLab.text = @"充值类型:";
    
    self.yueView.title.text = @"余额充值";
    
    self.jifenView.title.text = @"积分充值";
    
    [self.yueView.btn addTarget:self action:@selector(yueClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.jifenView.btn addTarget:self action:@selector(jifenClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.rechargeType isEqualToString:@"1"]) {
        
        [self.yueView.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.jifenView.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        self.countTitleLab.text = @"充值余额:";
        
    }else if ([model.rechargeType isEqualToString:@"2"]) {
        
        [self.yueView.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.jifenView.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        self.countTitleLab.text = @"充值积分:";
        
    }
    
    if ([self isBlankString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
        
        self.countField.text = [NSString stringWithFormat:@"%@",model.count];
        
    }
    
    
    
    self.countField.placeholder = @"输入充值数量";
    
    self.beizhuTitleLab.text = @"备注:";
    
    if ([self isBlankString:model.beizhu]) {
        
        self.beizhuField.text = @"";
        
    }else {
        
        self.beizhuField.text = [NSString stringWithFormat:@"%@",model.beizhu];
        
    }
    
    
    
    self.beizhuField.placeholder = @"充值原因";
    
    [self.sureBtn setTitle:@"确认充值" forState:0];
    
    [self.sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)yueClick {
    
    if (self.yueBlock) {
        
        self.yueBlock();
        
    }
    
}

- (void)jifenClick {
    
    if (self.jifenBlock) {
        
        self.jifenBlock();
        
    }
    
}

- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
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
