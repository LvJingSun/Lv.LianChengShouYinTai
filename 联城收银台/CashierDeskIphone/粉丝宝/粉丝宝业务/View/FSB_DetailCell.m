//
//  FSB_DetailCell.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailCell.h"
#import "FSB_Header.h"

@implementation FSB_DetailCell

+ (instancetype)FSB_DetailCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_DetailCell";
    
    FSB_DetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.1, 10, SCREENWIDTH * 0.3, 20)];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.textColor = [UIColor colorWithRed:22/255. green:22/255. blue:22/255. alpha:1.];
        
        [self addSubview:title];
        
        UILabel *value = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.4, 10, SCREENWIDTH * 0.55, 20)];
        
        self.valueLab = value;
        
        value.font = [UIFont systemFontOfSize:17];
        
        value.textColor = [UIColor colorWithRed:125/255. green:124/255. blue:124/255. alpha:1.];
        
        [self addSubview:value];
        
        self.height = CGRectGetMaxY(title.frame) + 10;
        
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
