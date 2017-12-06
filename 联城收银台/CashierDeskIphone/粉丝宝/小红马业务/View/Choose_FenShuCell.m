//
//  Choose_FenShuCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Choose_FenShuCell.h"
#import "Choose_FenShuModel.h"
#import "Choose_FenShuFrame.h"
#import "FSB_Header.h"

@interface Choose_FenShuCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation Choose_FenShuCell

+ (instancetype)Choose_FenShuCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Choose_FenShuCell";
    
    Choose_FenShuCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Choose_FenShuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = TitleColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Choose_FenShuFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    Choose_FenShuModel *model = self.frameModel.fenshumodel;
    
    self.nameLab.text = [NSString stringWithFormat:@"%@份",model.RedPNum];
    
    if ([model.isChoose isEqualToString:@"1"]) {
        
        self.iconImg.image = [UIImage imageNamed:@"Administration_default.png"];
        
    }else {
        
        self.iconImg.image = [UIImage imageNamed:@"Administration_nodefault.png"];
        
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
