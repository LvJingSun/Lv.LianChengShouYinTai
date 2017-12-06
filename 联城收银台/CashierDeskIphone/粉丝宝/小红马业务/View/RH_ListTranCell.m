//
//  RH_ListTranCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ListTranCell.h"
#import "FSB_Header.h"
#import "RH_ListTranModel.h"
#import "RH_ListTranFrame.h"

@interface RH_ListTranCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation RH_ListTranCell

+ (instancetype)RH_ListTranCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_ListTranCell";
    
    RH_ListTranCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_ListTranCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:18];
        
        count.textColor = [UIColor colorWithRed:206/255. green:0/255. blue:0/255. alpha:1.];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *product = [[UILabel alloc] init];
        
        self.productLab = product;
        
        product.font = [UIFont systemFontOfSize:15];
        
        product.textColor = [UIColor colorWithRed:61/255. green:60/255. blue:60/255. alpha:1.];
        
        [self addSubview:product];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.font = [UIFont systemFontOfSize:15];
        
        time.textColor = [UIColor colorWithRed:112/255. green:110/255. blue:110/255. alpha:1.];
        
        time.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:time];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];

    }
    
    return self;
    
}

-(void)setFrameModel:(RH_ListTranFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.productLab.frame = self.frameModel.productF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    RH_ListTranModel *model = self.frameModel.listModel;
    
    self.nameLab.text = model.Memberid;
    
    self.countLab.text = model.Num;
    
    self.productLab.text = model.Goodsname;
    
    self.timeLab.text = model.CreateDate;
    
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
