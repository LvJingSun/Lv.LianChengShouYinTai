//
//  FSB_UpLoadCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/24.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_UpLoadCell.h"
#import "FSB_UpLoadFrame.h"
#import "FSB_Header.h"
#import "FSB_TranInfoModel.h"

@interface FSB_UpLoadCell ()

@property (nonatomic, weak) UILabel *acountTitleLab;

@property (nonatomic, weak) UILabel *acountLab;

@property (nonatomic, weak) UILabel *acountTitleLineLab;

@property (nonatomic, weak) UILabel *nameTitleLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *nameTitleLineLab;

@property (nonatomic, weak) UILabel *productTitleLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *productTitleLineLab;

@property (nonatomic, weak) UILabel *tranCountTitleLab;

@property (nonatomic, weak) UILabel *tranCountLab;

@property (nonatomic, weak) UILabel *tranCountTitleLineLab;

@property (nonatomic, weak) UILabel *redCountTitleLab;

@property (nonatomic, weak) UILabel *redCountLab;

@property (nonatomic, weak) UILabel *redCountTitleLineLab;

@property (nonatomic, weak) UILabel *redCopiesTitleLab;

@property (nonatomic, weak) UILabel *redCopiesLab;

@property (nonatomic, weak) UILabel *redCopiesTitleLineLab;

@property (nonatomic, weak) UILabel *goldCountTitleLab;

@property (nonatomic, weak) UILabel *goldCountLab;

@property (nonatomic, weak) UILabel *goldCountTitleLineLab;

@property (nonatomic, weak) UILabel *staffTitleLab;

@property (nonatomic, weak) UILabel *staffLab;

@property (nonatomic, weak) UILabel *staffTitleLineLab;

@property (nonatomic, weak) UILabel *InvoiceTitleLab;

@property (nonatomic, weak) UIButton *AddInvoiceBtn;

@property (nonatomic, weak) UIView *SureBtnBGView;

@end

@implementation FSB_UpLoadCell

+ (instancetype)FSB_UpLoadCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_UpLoadCell";
    
    FSB_UpLoadCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_UpLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (UILabel *)allocTitleLab {
    
    UILabel *lab = [[UILabel alloc] init];
    
    lab.font = TitleFont;
    
    lab.textColor = TitleColor;
    
    return lab;
    
}

- (UILabel *)allocContentLab {
    
    UILabel *lab = [[UILabel alloc] init];
    
    lab.font = TitleFont;
    
    lab.textColor = [UIColor darkGrayColor];
    
    return lab;
    
}

- (UILabel *)allocLineLab {
    
    UILabel *line = [[UILabel alloc] init];
    
    line.backgroundColor = LineColor;
    
    return line;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *acounttitle = [self allocTitleLab];
        
        self.acountTitleLab = acounttitle;
        
        [self addSubview:acounttitle];
        
        UILabel *acountlab = [self allocContentLab];
        
        self.acountLab = acountlab;
        
        [self addSubview:acountlab];
        
        UILabel *acountline = [self allocLineLab];
        
        self.acountTitleLineLab = acountline;
        
        [self addSubview:acountline];
        
        UILabel *nametitle = [self allocTitleLab];
        
        self.nameTitleLab = nametitle;
        
        [self addSubview:nametitle];
        
        UILabel *namelab = [self allocContentLab];
        
        self.nameLab = namelab;
        
        [self addSubview:namelab];
        
        UILabel *nameline = [self allocLineLab];
        
        self.nameTitleLineLab = nameline;
        
        [self addSubview:nameline];
        
        UILabel *protitle = [self allocTitleLab];
        
        self.productTitleLab = protitle;
        
        [self addSubview:protitle];
        
        UILabel *prolab = [self allocContentLab];
        
        self.productLab = prolab;
        
        [self addSubview:prolab];
        
        UILabel *proline = [self allocLineLab];
        
        self.productTitleLineLab = proline;
        
        [self addSubview:proline];
        
        UILabel *trantitle = [self allocTitleLab];
        
        self.tranCountTitleLab = trantitle;
        
        [self addSubview:trantitle];
        
        UILabel *tranlab = [self allocContentLab];
        
        self.tranCountLab = tranlab;
        
        [self addSubview:tranlab];
        
        UILabel *tranline = [self allocLineLab];
        
        self.tranCountTitleLineLab = tranline;
        
        [self addSubview:tranline];
        
        UILabel *redcounttitle = [self allocTitleLab];
        
        self.redCountTitleLab = redcounttitle;
        
        [self addSubview:redcounttitle];
        
        UILabel *redcountlab = [self allocContentLab];
        
        self.redCountLab = redcountlab;
        
        [self addSubview:redcountlab];
        
        UILabel *redcountline = [self allocLineLab];
        
        self.redCountTitleLineLab = redcountline;
        
        [self addSubview:redcountline];
        
        UILabel *copiestitle = [self allocTitleLab];
        
        self.redCopiesTitleLab = copiestitle;
        
        [self addSubview:copiestitle];
        
        UILabel *copieslab = [self allocContentLab];
        
        self.redCopiesLab = copieslab;
        
        [self addSubview:copieslab];
        
        UILabel *copiesline = [self allocLineLab];
        
        self.redCopiesTitleLineLab = copiesline;
        
        [self addSubview:copiesline];
        
        UILabel *goldtitle = [self allocTitleLab];
        
        self.goldCountTitleLab = goldtitle;
        
        [self addSubview:goldtitle];
        
        UILabel *goldlab = [self allocContentLab];
        
        self.goldCountLab = goldlab;
        
        [self addSubview:goldlab];
        
        UILabel *goldline = [self allocLineLab];
        
        self.goldCountTitleLineLab = goldline;
        
        [self addSubview:goldline];
        
        UILabel *stafftitle = [self allocTitleLab];
        
        self.staffTitleLab = stafftitle;
        
        [self addSubview:stafftitle];
        
        UILabel *stafflab = [self allocContentLab];
        
        self.staffLab = stafflab;
        
        [self addSubview:stafflab];
        
        UILabel *staffline = [self allocLineLab];
        
        self.staffTitleLineLab = staffline;
        
        [self addSubview:staffline];
        
        UILabel *invoice = [self allocTitleLab];
        
        self.InvoiceTitleLab = invoice;
        
        [self addSubview:invoice];
        
        UIButton *addInvoiceBtn = [[UIButton alloc] init];
        
        self.AddInvoiceBtn = addInvoiceBtn;
        
        [self addSubview:addInvoiceBtn];
        
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

-(void)setFrameModel:(FSB_UpLoadFrame *)frameModel {

    _frameModel = frameModel;
    
    [self serRect];
    
    [self setContent];
    
}

- (void)serRect {
    
    self.acountTitleLab.frame = self.frameModel.acountTitleF;
    
    self.acountLab.frame = self.frameModel.acountF;
    
    self.acountTitleLineLab.frame = self.frameModel.acountLineF;
    
    self.nameTitleLab.frame = self.frameModel.nameTitleF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.nameTitleLineLab.frame = self.frameModel.nameLineF;

    self.productTitleLab.frame = self.frameModel.productTitleF;
    
    self.productLab.frame = self.frameModel.productF;
    
    self.productTitleLineLab.frame = self.frameModel.productLineF;
    
    self.tranCountTitleLab.frame = self.frameModel.tranCountTitleF;
    
    self.tranCountLab.frame = self.frameModel.tranCountF;
    
    self.tranCountTitleLineLab.frame = self.frameModel.tranCountLineF;
    
    self.redCountTitleLab.frame = self.frameModel.redCountTitleF;
    
    self.redCountLab.frame = self.frameModel.redCountF;
    
    self.redCountTitleLineLab.frame = self.frameModel.redCountLineF;
    
    self.redCopiesTitleLab.frame = self.frameModel.redCopiesTitleF;
    
    self.redCopiesLab.frame = self.frameModel.redCopiesF;
    
    self.redCopiesTitleLineLab.frame = self.frameModel.redCopiesLineF;
    
    self.goldCountTitleLab.frame = self.frameModel.goldCountTitleF;
    
    self.goldCountLab.frame = self.frameModel.goldCountF;
    
    self.goldCountTitleLineLab.frame = self.frameModel.goldCountLineF;
    
    self.staffTitleLab.frame = self.frameModel.staffTitleF;
    
    self.staffLab.frame = self.frameModel.staffF;
    
    self.staffTitleLineLab.frame = self.frameModel.staffLineF;
    
    self.InvoiceTitleLab.frame = self.frameModel.InvoiceTitleF;
    
    self.AddInvoiceBtn.frame = self.frameModel.AddInvoiceBtnF;
    
    self.SureBtn.frame = self.frameModel.SureBtnF;
    
    self.SureBtnBGView.frame = self.frameModel.SureBtnBGViewF;
    
}

- (void)setContent {

    FSB_TranInfoModel *model = self.frameModel.tranModel;
    
    self.acountTitleLab.text = @"账号：";
    
    self.acountLab.text = model.acount;
    
    self.nameTitleLab.text = @"姓名：";
    
    self.nameLab.text = model.name;
    
    self.productTitleLab.text = @"商品名称：";
    
    self.productLab.text = model.productName;
    
    self.tranCountTitleLab.text = @"交易金额：";
    
    self.tranCountLab.text = model.tranCount;
    
    self.redCountTitleLab.text = @"红包金额：";
    
    self.redCountLab.text = model.redCount;
    
    self.redCopiesTitleLab.text = @"红包份数：";
    
    self.redCopiesLab.text = model.redCopiesName;
    
    if ([model.redType isEqualToString:@"1"]) {
        
        self.goldCountTitleLab.text = @"积分：";
        
        self.goldCountLab.text = model.jifen;
        
    }else if ([model.redType isEqualToString:@"0"]) {
        
        self.goldCountTitleLab.text = @"金种子：";
        
        self.goldCountLab.text = model.goldCount;
        
    }
    
    self.staffTitleLab.text = @"促销员：";
    
    self.staffLab.text = model.staffName;
    
    self.InvoiceTitleLab.text = @"请上传发票";
    
    if (model.InvoiceImg == nil) {
        
        [self.AddInvoiceBtn setImage:[UIImage imageNamed:@"Car_infoAdd.png"] forState:0];
        
    }else {
        
        [self.AddInvoiceBtn setImage:model.InvoiceImg forState:0];
        
    }
    
    [self.AddInvoiceBtn addTarget:self action:@selector(addInvoiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.SureBtn setTitle:@"确定" forState:0];
    
    [self.SureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addInvoiceBtnClick {

    if (self.InvoiceBlock) {
        
        self.InvoiceBlock();
        
    }
    
}

- (void)sureBtnClick {

    if (self.SureBlock) {
        
        self.SureBlock();
        
    }
    
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
