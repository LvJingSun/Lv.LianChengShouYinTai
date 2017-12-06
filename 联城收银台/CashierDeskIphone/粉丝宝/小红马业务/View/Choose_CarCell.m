//
//  Choose_CarCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Choose_CarCell.h"
#import "ChooseCarModel.h"
#import "Choose_CarFrame.h"
#import "FSB_Header.h"
#import "UIImageView+AFNetworking.h"

@interface Choose_CarCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *plateLab;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UIImageView *chooseImg;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation Choose_CarCell

+ (instancetype)Choose_CarCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Choose_CarCell";
    
    Choose_CarCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Choose_CarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = TitleColor;
        
        name.font = TitleFont;
        
        [self addSubview:name];
        
        UILabel *plate = [[UILabel alloc] init];
        
        self.plateLab = plate;
        
        plate.textColor = TitleColor;
        
        plate.font = TitleFont;
        
        [self addSubview:plate];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        [self addSubview:icon];
        
        UIImageView *choose = [[UIImageView alloc] init];
        
        self.chooseImg = choose;
        
        [self addSubview:choose];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = TitleColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Choose_CarFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.nameLab.frame = self.frameModel.nameF;
    
    self.plateLab.frame = self.frameModel.plateF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.iconImg.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.chooseImg.frame = self.frameModel.chooseF;
    
}

- (void)setContent {

    ChooseCarModel *model = self.frameModel.carmodel;
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.BrandName];
    
    self.plateLab.text = [NSString stringWithFormat:@"%@",model.CarNo];
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.CarIcon]] placeholderImage:[UIImage imageNamed:@""]];
    
    if ([model.isChoose isEqualToString:@"1"]) {
        
        self.chooseImg.image = [UIImage imageNamed:@"Administration_default.png"];
        
    }else {
        
        self.chooseImg.image = [UIImage imageNamed:@"Administration_nodefault.png"];
        
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
