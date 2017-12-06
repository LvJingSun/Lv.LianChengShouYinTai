//
//  Member_RecordCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Member_RecordCell.h"
#import "Member_RecordModel.h"
#import "Member_RecordFrame.h"
#import "FSB_Header.h"

@interface Member_RecordCell ()

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation Member_RecordCell

+ (instancetype)Member_RecordCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"Member_RecordCell";
    
    Member_RecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Member_RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        count.textColor = [UIColor colorWithRed:0/255. green:179/255. blue:0/255. alpha:1.];
        
        count.textAlignment = NSTextAlignmentRight;
        
        count.font = [UIFont systemFontOfSize:22];
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = BGColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Member_RecordFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    Member_RecordModel *model = self.frameModel.recordModel;
    
    self.typeLab.text = [NSString stringWithFormat:@"%@",model.name];
    
    self.dateLab.text = [NSString stringWithFormat:@"%@",model.date];
    
    self.countLab.text = [NSString stringWithFormat:@"%@",model.count];
    
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
