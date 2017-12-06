//
//  Q_DanJuCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Q_DanJuCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation Q_DanJuCell

+ (instancetype)Q_DanJuCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Q_DanJuCell";
    
    Q_DanJuCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Q_DanJuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 5, SCREEN_WIDTH * 0.3, 35)];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textColor = [UIColor darkGrayColor];
        
        [self addSubview:title];
        
        UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.4, 5, SCREEN_WIDTH * 0.55, 35)];
        
        self.valueLab = value;
        
        value.font = [UIFont systemFontOfSize:17];
        
        value.textColor = [UIColor blackColor];
        
        value.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:value];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.4, CGRectGetMaxY(value.frame), SCREEN_WIDTH * 0.55, 1)];
        
        line.backgroundColor = [UIColor colorWithRed:107/255. green:199/255. blue:240/255. alpha:1.];
        
        [self addSubview:line];
        
        UILabel *ll = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + 5, SCREEN_WIDTH, 0.5)];
        
        ll.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:ll];
        
        self.height = CGRectGetMaxY(ll.frame);
        
    }
    
    return self;
    
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
