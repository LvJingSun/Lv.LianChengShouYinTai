//
//  FSB_ListCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_ListCell.h"
#import "FSB_ListFrame.h"
#import "FSB_ListModel.h"
#import "FSB_Header.h"

@interface FSB_ListCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UIImageView *statusImg;

@end

@implementation FSB_ListCell

+ (instancetype)FSB_ListCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_ListCell";
    
    FSB_ListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        UIImageView *statusimg = [[UIImageView alloc] init];
        
        self.statusImg = statusimg;
        
        [self addSubview:statusimg];
        
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

-(void)setFrameModel:(FSB_ListFrame *)frameModel {

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
    
    self.statusImg.frame = self.frameModel.statusF;
    
}

- (void)setContent {

    FSB_ListModel *model = self.frameModel.listModel;
    
    self.nameLab.text = model.Memberid;
    
    if ([model.type_name isEqualToString:@"商户红包"]) {
    
        self.countLab.text = @"商户红包";
        
    }else {

        self.countLab.text = model.Num;

    }

    self.productLab.text = model.Goodsname;
    
    self.timeLab.text = model.CreateDate;
    
    if ([model.TranStatus isEqualToString:@"1"]) {
        
        if ([model.Commit isEqualToString:@"已提交"]) {
            
            self.statusImg.image = [UIImage imageNamed:@"fsb_已提交.png"];
            
        }else if ([model.Commit isEqualToString:@"未提交"]) {
        
            self.statusImg.image = [UIImage imageNamed:@"fsb_未提交.png"];
            
        }
        
    }else if ([model.TranStatus isEqualToString:@"2"]) {
    
        self.statusImg.image = [UIImage imageNamed:@"fsb_已退回.png"];
        
    }else if ([model.TranStatus isEqualToString:@"3"]) {
        
        self.statusImg.image = [UIImage imageNamed:@"fsb_已撤销.png"];
        
    }
    
}

- (void)layoutSubviews {
    
    for (UIView *subView in self.subviews) {
        
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            // 拿到subView之后再获取子控件
            
            // 因为上面删除按钮是第二个加的所以下标是1
            UIView *phoneConfirmationView = subView.subviews[0];
            //改背景颜色
            phoneConfirmationView.backgroundColor = NAVTextColor;
            
        }
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
