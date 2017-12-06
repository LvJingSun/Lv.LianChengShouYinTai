//
//  FSB_InPutCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_InPutCell.h"
#import "FSB_InPutFrame.h"
#import "FSB_TranInfoModel.h"
#import "FSB_Header.h"
#import "RH_RadioView.h"

@interface FSB_InPutCell ()

@property (nonatomic, weak) UILabel *productTitleLab;

@property (nonatomic, weak) UITextField *productField;

@property (nonatomic, weak) UIButton *productBtn;

@property (nonatomic, weak) UILabel *productTitleLineLab;

@property (nonatomic, weak) UILabel *tranCountTitleLab;

@property (nonatomic, weak) UITextField *tranCountField;

@property (nonatomic, weak) UILabel *tranCountTitleLineLab;

@property (nonatomic, weak) UILabel *redTypeTitleLab;

@property (nonatomic, weak) RH_RadioView *type_merchant;

@property (nonatomic, weak) RH_RadioView *type_pingtai;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, weak) RH_RadioView *merchant_huiyuanka;

@property (nonatomic, weak) RH_RadioView *merchant_tixian;

@property (nonatomic, weak) UILabel *redTypeLineLab;

@property (nonatomic, weak) UILabel *redCountTitleLab;

@property (nonatomic, weak) UITextField *redCountField;

@property (nonatomic, weak) UILabel *redCountTitleLineLab;

@property (nonatomic, weak) UILabel *redCopiesTitleLab;

@property (nonatomic, weak) UITextField *redCopiesField;

@property (nonatomic, weak) UIButton *redCopiesBtn;

@property (nonatomic, weak) UILabel *redCopiesTitleLineLab;

@property (nonatomic, weak) UILabel *jifenCountTitleLab;

@property (nonatomic, weak) UITextField *jifenCountField;

@property (nonatomic, weak) UILabel *jifenCountTitleLineLab;

@property (nonatomic, weak) UILabel *goldCountTitleLab;

@property (nonatomic, weak) UITextField *goldCountField;

@property (nonatomic, weak) UILabel *goldCountTitleLineLab;

@property (nonatomic, weak) UILabel *staffTitleLab;

@property (nonatomic, weak) UITextField *staffField;

@property (nonatomic, weak) UIButton *staffBtn;

@property (nonatomic, weak) UILabel *staffTitleLineLab;

@property (nonatomic, weak) UIButton *SureBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation FSB_InPutCell

+ (instancetype)FSB_InPutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_InPutCell";
    
    FSB_InPutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_InPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *protitle = [self allocTitleLab];
        
        self.productTitleLab = protitle;
        
        [self addSubview:protitle];
        
        UITextField *profield = [self allocTextfield];
        
        self.productField = profield;
        
        profield.placeholder = @"请输入商品名称";
        
        profield.userInteractionEnabled = NO;
        
        [self addSubview:profield];
        
        UIButton *productbtn = [[UIButton alloc] init];
        
        self.productBtn = productbtn;
        
        [self addSubview:productbtn];
        
        UILabel *proline = [self allocLineLab];
        
        self.productTitleLineLab = proline;
        
        [self addSubview:proline];
        
        UILabel *trancounttitle = [self allocTitleLab];
        
        self.tranCountTitleLab = trancounttitle;

        [self addSubview:trancounttitle];
        
        UITextField *trancount = [self allocTextfield];
        
        self.tranCountField = trancount;
        
        trancount.placeholder = @"请输入交易金额";
        
        trancount.keyboardType = UIKeyboardTypeDecimalPad;
        
        [trancount addTarget:self action:@selector(trancountChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:trancount];
        
        UILabel *trancountline = [self allocLineLab];
        
        self.tranCountTitleLineLab = trancountline;
        
        [self addSubview:trancountline];
        
        UILabel *redTypeTitle = [self allocTitleLab];
        
        self.redTypeTitleLab = redTypeTitle;
        
        [self addSubview:redTypeTitle];
        
        UILabel *redTypeLine = [self allocLineLab];
        
        self.redTypeLineLab = redTypeLine;
        
        [self addSubview:redTypeLine];
        
        UILabel *redcounttitle = [self allocTitleLab];
        
        self.redCountTitleLab = redcounttitle;
        
        [self addSubview:redcounttitle];
        
        UITextField *redcount = [self allocTextfield];
        
        self.redCountField = redcount;
        
        redcount.placeholder = @"请输入红包金额";
        
        redcount.keyboardType = UIKeyboardTypeDecimalPad;
        
        [redcount addTarget:self action:@selector(redcountChange:) forControlEvents:UIControlEventEditingChanged];
        
        [redcount addTarget:self action:@selector(redcountEndChange:) forControlEvents:UIControlEventEditingDidEnd];
        
        [self addSubview:redcount];
        
        UILabel *redcountline = [self allocLineLab];
        
        self.redCountTitleLineLab = redcountline;
        
        [self addSubview:redcountline];
        
        UILabel *redcopiestitle = [self allocTitleLab];
        
        self.redCopiesTitleLab = redcopiestitle;
        
        [self addSubview:redcopiestitle];
        
        UITextField *redcopies = [self allocTextfield];
        
        self.redCopiesField = redcopies;
        
        redcopies.placeholder = @"请选择红包份数";
        
        redcopies.userInteractionEnabled = NO;
        
        [self addSubview:redcopies];
        
        UIButton *copiesbtn = [[UIButton alloc] init];
        
        self.redCopiesBtn = copiesbtn;
        
        [self addSubview:copiesbtn];
        
        UILabel *redcopiesline = [self allocLineLab];
        
        self.redCopiesTitleLineLab = redcopiesline;
        
        [self addSubview:redcopiesline];
        
        
        UILabel *jifencounttitle = [self allocTitleLab];
        
        self.jifenCountTitleLab = jifencounttitle;
        
        [self addSubview:jifencounttitle];
        
        UITextField *jifencount = [self allocTextfield];
        
        self.jifenCountField = jifencount;
        
        jifencount.placeholder = @"积分";
        
        jifencount.keyboardType = UIKeyboardTypeDecimalPad;
        
        [jifencount addTarget:self action:@selector(jifencountChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:jifencount];
        
        UILabel *jifencountline = [self allocLineLab];
        
        self.jifenCountTitleLineLab = jifencountline;
        
        [self addSubview:jifencountline];
        
        
        
        
        UILabel *goldcounttitle = [self allocTitleLab];
        
        self.goldCountTitleLab = goldcounttitle;
        
        [self addSubview:goldcounttitle];
        
        UITextField *goldcount = [self allocTextfield];
        
        self.goldCountField = goldcount;
        
        goldcount.placeholder = @"金种子数量";
        
        goldcount.userInteractionEnabled = NO;
        
        [self addSubview:goldcount];
        
        UILabel *goldcountline = [self allocLineLab];
        
        self.goldCountTitleLineLab = goldcountline;
        
        [self addSubview:goldcountline];
        
        UILabel *stafftitle = [self allocTitleLab];
        
        self.staffTitleLab = stafftitle;
        
        [self addSubview:stafftitle];
        
        UITextField *staff = [self allocTextfield];
        
        self.staffField = staff;
        
        staff.placeholder = @"请选择促销员";
        
        staff.userInteractionEnabled = NO;
        
        [self addSubview:staff];
        
        UIButton *staffbtn = [[UIButton alloc] init];
        
        self.staffBtn = staffbtn;
        
        [self addSubview:staffbtn];
        
        UILabel *staffline = [self allocLineLab];
        
        self.staffTitleLineLab = staffline;
        
        [self addSubview:staffline];
        
        UIView *bg = [[UIView alloc] init];
        
        self.SureBtnBGView = bg;
        
        bg.backgroundColor = BGColor;
        
        [self addSubview:bg];
        
        UIButton *sureBtn = [[UIButton alloc] init];
        
        self.SureBtn = sureBtn;
        
        [sureBtn setBackgroundColor:NAVTextColor];
        
        [sureBtn setTitleColor:[UIColor whiteColor] forState:0];
        
        sureBtn.layer.masksToBounds = YES;
        
        sureBtn.layer.cornerRadius = 5;
        
        [self addSubview:sureBtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(FSB_InPutFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    [self.frameModel getCellHeight];

    self.productTitleLab.frame = self.frameModel.productTitleF;
    
    self.productField.frame = self.frameModel.productF;
    
    self.productBtn.frame = self.frameModel.productF;
    
    self.productTitleLineLab.frame = self.frameModel.productLineF;
    
    self.tranCountTitleLab.frame = self.frameModel.tranCountTitleF;
    
    self.tranCountField.frame = self.frameModel.tranCountF;
    
    self.tranCountTitleLineLab.frame = self.frameModel.tranCountLineF;
    
    self.redTypeTitleLab.frame = self.frameModel.redTypeTitleF;
    
    RH_RadioView *type_merchant = [[RH_RadioView alloc] initWithFrame:self.frameModel.type_merchantF];
    
    self.type_merchant = type_merchant;
    
    [self addSubview:type_merchant];
    
    RH_RadioView *type_pingtai = [[RH_RadioView alloc] initWithFrame:self.frameModel.type_pingtaiF];
    
    self.type_pingtai = type_pingtai;
    
    [self addSubview:type_pingtai];
    
    if ([self.frameModel.tranModel.redType isEqualToString:@"0"]) {
        
        self.redTypeLineLab.frame = self.frameModel.redTypeLineF;
        
        self.goldCountTitleLab.frame = self.frameModel.goldCountTitleF;
        
        self.goldCountField.frame = self.frameModel.goldCountF;
        
        self.goldCountTitleLineLab.frame = self.frameModel.goldCountLineF;
        
    }else if ([self.frameModel.tranModel.redType isEqualToString:@"1"]) {
        
        UILabel *notice = [[UILabel alloc] initWithFrame:self.frameModel.noticeF];
        
        self.noticeLab = notice;
        
        notice.font = [UIFont systemFontOfSize:13];
        
        notice.textColor = [UIColor darkGrayColor];
        
        [self addSubview:notice];
        
        RH_RadioView *merchant_huiyuanka = [[RH_RadioView alloc] initWithFrame:self.frameModel.merchant_huiyuankaF];
        
        self.merchant_huiyuanka = merchant_huiyuanka;
        
        [self addSubview:merchant_huiyuanka];
        
        RH_RadioView *merchant_tixian = [[RH_RadioView alloc] initWithFrame:self.frameModel.merchant_tixianF];
        
        self.merchant_tixian = merchant_tixian;
        
        [self addSubview:merchant_tixian];
        
        self.redTypeLineLab.frame = self.frameModel.redTypeLineF;
        
        self.jifenCountTitleLab.frame = self.frameModel.jifenCountTitleF;
        
        self.jifenCountField.frame = self.frameModel.jifenCountF;
        
        self.jifenCountTitleLineLab.frame = self.frameModel.jifenCountLineF;
        
    }
    
    self.redCountTitleLab.frame = self.frameModel.redCountTitleF;
    
    self.redCountField.frame = self.frameModel.redCountF;
    
    self.redCountTitleLineLab.frame = self.frameModel.redCountLineF;
    
    self.redCopiesTitleLab.frame = self.frameModel.redCopiesTitleF;
    
    self.redCopiesField.frame = self.frameModel.redCopiesF;
    
    self.redCopiesBtn.frame = self.frameModel.redCopiesF;
    
    self.redCopiesTitleLineLab.frame = self.frameModel.redCopiesLineF;
    
    self.staffTitleLab.frame = self.frameModel.staffTitleF;
    
    self.staffField.frame = self.frameModel.staffF;
    
    self.staffBtn.frame = self.frameModel.staffF;
    
    self.staffTitleLineLab.frame = self.frameModel.staffLineF;
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;
    
}

- (void)setContent {
    
    [self.frameModel getCellHeight];
    
    FSB_TranInfoModel *model = self.frameModel.tranModel;

    self.productTitleLab.text = @"商品名称：";
    
    if ([self isNULLString:model.productName]) {
        
        self.productField.text = @"";
        
    }else {
    
        self.productField.text = model.productName;
        
    }
    
    [self.productBtn addTarget:self action:@selector(productClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tranCountTitleLab.text = @"交易金额：";
    
    if ([self isNULLString:model.tranCount]) {
        
        self.tranCountField.text = @"";
        
    }else {
        
        self.tranCountField.text = model.tranCount;
        
    }
    
    self.redTypeTitleLab.text = @"红包类型：";
    
    self.noticeLab.text = @"请选择红包用途：";
    
    self.type_merchant.title.text = @"商户";
    
    self.type_pingtai.title.text = @"平台";
    
    [self.type_merchant.btn addTarget:self action:@selector(type_merchantClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.type_pingtai.btn addTarget:self action:@selector(type_pingtaiClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.goldCountTitleLab.text = @"金种子：";
    
    if ([self isNULLString:model.goldCount]) {
        
        self.goldCountField.text = @"";
        
    }else {
        
        self.goldCountField.text = model.goldCount;
        
    }
    
    self.jifenCountTitleLab.text = @"积分：";
    
    if ([self isNULLString:model.jifen]) {
        
        self.jifenCountField.text = @"";
        
    }else {
        
        self.jifenCountField.text = model.jifen;
        
    }
    
    if ([model.redType isEqualToString:@"1"]) {
        
        self.goldCountTitleLab.hidden = YES;
        
        self.goldCountField.hidden = YES;
        
        self.goldCountTitleLineLab.hidden = YES;
        
        self.jifenCountTitleLab.hidden = NO;
        
        self.jifenCountField.hidden = NO;
        
        self.jifenCountTitleLineLab.hidden = NO;
        
        [self.type_merchant.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        [self.type_pingtai.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        self.merchant_huiyuanka.title.text = @"会员卡余额【限在本商户消费】";
        
        self.merchant_tixian.title.text = @"会员卡红包【可提现至城与城余额】";
        
        [self.merchant_huiyuanka.btn addTarget:self action:@selector(merchant_huiyuankaClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.merchant_tixian.btn addTarget:self action:@selector(merchant_tixianClick) forControlEvents:UIControlEventTouchUpInside];
        
        if ([model.merchantRedType isEqualToString:@"1"]) {
            
            [self.merchant_huiyuanka.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
            
            [self.merchant_tixian.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
            
        }else if ([model.merchantRedType isEqualToString:@"2"]) {
            
            [self.merchant_huiyuanka.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
            
            [self.merchant_tixian.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
            
        }
        
    }else if ([model.redType isEqualToString:@"0"]) {
        
        self.goldCountTitleLab.hidden = NO;
        
        self.goldCountField.hidden = NO;
        
        self.goldCountTitleLineLab.hidden = NO;
        
        self.jifenCountTitleLab.hidden = YES;
        
        self.jifenCountField.hidden = YES;
        
        self.jifenCountTitleLineLab.hidden = YES;
        
        [self.type_merchant.btn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        [self.type_pingtai.btn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
    }
    
    self.redCountTitleLab.text = @"红包金额：";
    
    if ([self isNULLString:model.redCount]) {
        
        self.redCountField.text = @"";
        
    }else {
        
        self.redCountField.text = model.redCount;
        
    }
    
    self.redCopiesTitleLab.text = @"红包份数：";
    
    if ([self isNULLString:model.redCopiesName]) {
        
        self.redCopiesField.text = @"";
        
    }else {
        
        self.redCopiesField.text = model.redCopiesName;
        
    }
    
    [self.redCopiesBtn addTarget:self action:@selector(redCopiesClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.staffTitleLab.text = @"促销员：";
    
    if ([self isNULLString:model.staffName]) {
        
        self.staffField.text = @"";
        
    }else {
        
        self.staffField.text = model.staffName;
        
    }
    
    [self.staffBtn addTarget:self action:@selector(staffClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SureBtn setTitle:@"确定" forState:0];
    
    [self.SureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)type_merchantClick {
    
    if (self.type_merchantBlock) {
        
        self.type_merchantBlock();
        
    }
    
}

- (void)type_pingtaiClick {
    
    if (self.type_pingtaiBlock) {
        
        self.type_pingtaiBlock();
        
    }
    
}

- (void)merchant_huiyuankaClick {
    
    if (self.merchant_huiyuankaBlock) {
        
        self.merchant_huiyuankaBlock();
        
    }
    
}

- (void)merchant_tixianClick {
    
    if (self.merchant_tixianBlock) {
        
        self.merchant_tixianBlock();
        
    }
    
}

//商品名称点击
- (void)productClick {

    if (self.productBlock) {
        
        self.productBlock();
        
    }
    
    [self hideKeyboard];
    
}

//红包份数点击
- (void)redCopiesClick {

    if (self.redCopiesBlock) {
        
        self.redCopiesBlock();
        
    }
    
    [self hideKeyboard];
    
}

//促销员点击
- (void)staffClick {
    
    if (self.staffBlock) {
        
        self.staffBlock();
        
    }
    
    [self hideKeyboard];
    
}

//确定点击
- (void)sureClick {
    
    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
    [self hideKeyboard];
    
}

//红包金额输入完成代理
- (void)redcountEndChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(RedCountFieldEndChange:)]) {
        
        [self.delegate RedCountFieldEndChange:field];
        
    }
    
}

- (void)jifencountChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(JiFenCountFieldChange:)]) {
        
        [self.delegate JiFenCountFieldChange:field];
        
    }
    
}

//消费金额代理
- (void)trancountChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(TranCountFieldChange:)]) {
        
        [self.delegate TranCountFieldChange:field];
        
    }
    
}

//红包金额代理
- (void)redcountChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(RedCountFieldChange:)]) {
        
        [self.delegate RedCountFieldChange:field];
        
    }
    
}

- (UILabel *)allocTitleLab {
    
    UILabel *lab = [[UILabel alloc] init];
    
    lab.font = TitleFont;
    
    lab.textColor = TitleColor;
    
    return lab;
    
}

- (UITextField *)allocTextfield {
    
    UITextField *field = [[UITextField alloc] init];
    
    field.font = TitleFont;
    
    field.textColor = TitleColor;
    
    return field;
    
}

- (UILabel *)allocLineLab {
    
    UILabel *line = [[UILabel alloc] init];
    
    line.backgroundColor = LineColor;
    
    return line;
    
}

- (BOOL)isNULLString:(NSString *)string {
    
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

- (void)hideKeyboard {

    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hideKeyboard];
    
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
