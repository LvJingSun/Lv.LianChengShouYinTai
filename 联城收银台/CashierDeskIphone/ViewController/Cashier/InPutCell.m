//
//  InPutCell.m
//  CashierDeskIphone
//
//  Created by mac on 2016/11/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "InPutCell.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation InPutCell

+ (instancetype)InPutCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"InPutCell";
    
    InPutCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[InPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 20, SCREEN_WIDTH * 0.8, 25)];
        
        self.titleLab = title;
        
        title.textColor = [UIColor colorWithRed:51/255. green:51/255. blue:51/255. alpha:1.];
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 64.5, SCREEN_WIDTH * 0.95, 0.5)];
        
        line.backgroundColor = [UIColor colorWithRed:240/255. green:239/255. blue:240/255. alpha:1.];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
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
