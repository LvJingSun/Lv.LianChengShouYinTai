//
//  RH_InPutCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InPutCell.h"
#import "RH_InPutFrame.h"
#import "RH_TranInfoModel.h"
#import "FSB_Header.h"

@interface RH_InPutCell ()

@property (nonatomic, weak) UILabel *productTitleLab;

@property (nonatomic, weak) UITextField *productField;

@property (nonatomic, weak) UILabel *productTitleLineLab;

@property (nonatomic, weak) UIButton *carChooseBtn;

@property (nonatomic, weak) UILabel *redCountTitleLab;

@property (nonatomic, weak) UITextField *redCountField;

@property (nonatomic, weak) UILabel *redCountTitleLineLab;

@property (nonatomic, weak) UILabel *redCopiesTitleLab;

@property (nonatomic, weak) UITextField *redCopiesField;

@property (nonatomic, weak) UIButton *redCopiesBtn;

@property (nonatomic, weak) UILabel *redCopiesTitleLineLab;

@property (nonatomic, weak) UILabel *redProportionTitleLab;

@property (nonatomic, weak) UITextField *redProportionField;

@property (nonatomic, weak) UIButton *redProportionBtn;

@property (nonatomic, weak) UILabel *redProportionTitleLineLab;

@property (nonatomic, weak) UILabel *goldCountTitleLab;

@property (nonatomic, weak) UITextField *goldCountField;

@property (nonatomic, weak) UILabel *goldCountTitleLineLab;

//@property (nonatomic, weak) UILabel *staffTitleLab;
//
//@property (nonatomic, weak) UITextField *staffField;
//
//@property (nonatomic, weak) UIButton *staffBtn;
//
//@property (nonatomic, weak) UILabel *staffTitleLineLab;

@property (nonatomic, weak) UIButton *SureBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation RH_InPutCell

+ (instancetype)RH_InPutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_InPutCell";
    
    RH_InPutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_InPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        profield.placeholder = @"请选择汽车";

        profield.userInteractionEnabled = NO;
        
        [self addSubview:profield];
        
        UIButton *carbtn = [[UIButton alloc] init];
        
        self.carChooseBtn = carbtn;
        
        [self addSubview:carbtn];
        
        UILabel *proline = [self allocLineLab];
        
        self.productTitleLineLab = proline;
        
        [self addSubview:proline];
        
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
        
        UILabel *redproportiontitle = [self allocTitleLab];
        
        self.redProportionTitleLab = redproportiontitle;
        
        [self addSubview:redproportiontitle];
        
        UITextField *redproportion = [self allocTextfield];
        
        self.redProportionField = redproportion;
        
        redproportion.placeholder = @"请选择到账比例";
        
        redproportion.userInteractionEnabled = NO;
        
        [self addSubview:redproportion];
        
        UIButton *proportionbtn = [[UIButton alloc] init];
        
        self.redProportionBtn = proportionbtn;
        
        [self addSubview:proportionbtn];
        
        UILabel *redproportionline = [self allocLineLab];
        
        self.redProportionTitleLineLab = redproportionline;
        
        [self addSubview:redproportionline];
        
        UILabel *goldcounttitle = [self allocTitleLab];
        
        self.goldCountTitleLab = goldcounttitle;
        
        [self addSubview:goldcounttitle];
        
        UITextField *goldcount = [self allocTextfield];
        
        self.goldCountField = goldcount;
        
        goldcount.placeholder = @"服务费";
        
        goldcount.userInteractionEnabled = NO;
        
        [self addSubview:goldcount];
        
        UILabel *goldcountline = [self allocLineLab];
        
        self.goldCountTitleLineLab = goldcountline;
        
        [self addSubview:goldcountline];
        
//        UILabel *stafftitle = [self allocTitleLab];
//        
//        self.staffTitleLab = stafftitle;
//        
//        [self addSubview:stafftitle];
//        
//        UITextField *staff = [self allocTextfield];
//        
//        self.staffField = staff;
//        
//        staff.placeholder = @"请选择促销员";
//        
//        staff.userInteractionEnabled = NO;
//        
//        [self addSubview:staff];
//        
//        UIButton *staffbtn = [[UIButton alloc] init];
//        
//        self.staffBtn = staffbtn;
//        
//        [self addSubview:staffbtn];
//        
//        UILabel *staffline = [self allocLineLab];
//        
//        self.staffTitleLineLab = staffline;
//        
//        [self addSubview:staffline];
        
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

-(void)setFrameModel:(RH_InPutFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.productTitleLab.frame = self.frameModel.productTitleF;
    
    self.productField.frame = self.frameModel.productF;
    
    self.productTitleLineLab.frame = self.frameModel.productLineF;
    
    self.carChooseBtn.frame = self.frameModel.productF;
    
    self.redCountTitleLab.frame = self.frameModel.redCountTitleF;
    
    self.redCountField.frame = self.frameModel.redCountF;
    
    self.redCountTitleLineLab.frame = self.frameModel.redCountLineF;
    
    self.redCopiesTitleLab.frame = self.frameModel.redCopiesTitleF;
    
    self.redCopiesField.frame = self.frameModel.redCopiesF;
    
    self.redCopiesBtn.frame = self.frameModel.redCopiesF;
    
    self.redCopiesTitleLineLab.frame = self.frameModel.redCopiesLineF;
    
    self.redProportionTitleLab.frame = self.frameModel.redProportionTitleF;
    
    self.redProportionField.frame = self.frameModel.redProportionF;
    
    self.redProportionBtn.frame = self.frameModel.redProportionF;
    
    self.redProportionTitleLineLab.frame = self.frameModel.redProportionLineF;
    
    self.goldCountTitleLab.frame = self.frameModel.goldCountTitleF;
    
    self.goldCountField.frame = self.frameModel.goldCountF;
    
    self.goldCountTitleLineLab.frame = self.frameModel.goldCountLineF;
    
//    self.staffTitleLab.frame = self.frameModel.staffTitleF;
//    
//    self.staffField.frame = self.frameModel.staffF;
//    
//    self.staffBtn.frame = self.frameModel.staffF;
//    
//    self.staffTitleLineLab.frame = self.frameModel.staffLineF;
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;
    
}

- (void)setContent {
    
    RH_TranInfoModel *model = self.frameModel.tranModel;
    
    self.productTitleLab.text = @"汽车信息：";
    
    if ([self isNULLString:model.carName]) {
        
        self.productField.text = @"";
        
    }else {
        
        self.productField.text = model.carName;
        
    }
    
    [self.carChooseBtn addTarget:self action:@selector(carChooseClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    self.redProportionTitleLab.text = @"到账比例：";
    
    if ([self isNULLString:model.redProportion]) {
        
        self.redProportionField.text = @"";
        
    }else {
        
        self.redProportionField.text = model.redProportion;
        
    }
    
    [self.redProportionBtn addTarget:self action:@selector(redProportionClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.goldCountTitleLab.text = @"服务费：";
    
    if ([self isNULLString:model.goldCount]) {
        
        self.goldCountField.text = @"";
        
    }else {
        
        self.goldCountField.text = model.goldCount;
        
    }
    
//    self.staffTitleLab.text = @"促销员：";
//    
//    if ([self isNULLString:model.staffName]) {
//        
//        self.staffField.text = @"";
//        
//    }else {
//        
//        self.staffField.text = model.staffName;
//        
//    }
//    
//    [self.staffBtn addTarget:self action:@selector(staffClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SureBtn setTitle:@"确定" forState:0];
    
    [self.SureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//选择汽车点击
- (void)carChooseClick {
    
    if (self.chooseCarBlock) {
        
        self.chooseCarBlock();
        
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

//红包比例点击
- (void)redProportionClick {

    if (self.redProportionBlock) {
        
        self.redProportionBlock();
        
    }
    
    [self hideKeyboard];
    
}

////促销员点击
//- (void)staffClick {
//    
//    if (self.staffBlock) {
//        
//        self.staffBlock();
//        
//    }
//    
//    [self hideKeyboard];
//    
//}

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
