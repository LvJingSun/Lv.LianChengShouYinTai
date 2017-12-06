//
//  N_ShouYinCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_ShouYinCell.h"
#import "N_ShouYinModel.h"
#import "N_ShouYinFrame.h"
#import "FSB_Header.h"

@interface N_ShouYinCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation N_ShouYinCell

+ (instancetype)N_ShouYinCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"N_ShouYinCell";
    
    N_ShouYinCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[N_ShouYinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textColor = [UIColor darkTextColor];
        
        type.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:type];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textColor = [UIColor darkGrayColor];
        
        date.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:date];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = NAVTextColor;
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.textColor = [UIColor darkGrayColor];
        
        status.textAlignment = NSTextAlignmentRight;
        
        status.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:status];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = BGColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(N_ShouYinFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    N_ShouYinModel *model = self.frameModel.recordModel;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",model.Title];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.Date];
    
    self.countLab.text = [NSString stringWithFormat:@"%@",model.Amount];
    
    self.statusLab.text = [NSString stringWithFormat:@"%@",model.stylename];
    
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
