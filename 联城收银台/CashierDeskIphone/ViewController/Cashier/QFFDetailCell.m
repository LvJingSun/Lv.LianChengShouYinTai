//
//  QFFDetailCell.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFDetailCell.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFDetailCell

+ (instancetype)QFFDetailCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"QFFDetailCell";
    
    QFFDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[QFFDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.032, 10, SCREEN_WIDTH * 0.318, 25)];
        
        self.nameLab = name;
        
        name.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:name];
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.032, CGRectGetMaxY(name.frame) + 10, SCREEN_WIDTH * 0.318, 20)];
        
        self.timeLab = time;
        
        time.textColor = [UIColor lightGrayColor];
        
        time.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:time];
        
        self.height = CGRectGetMaxY(time.frame) + 10;
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 0.5, SCREEN_WIDTH, 0.5)];
        
        line.backgroundColor = [UIColor blackColor];
        
        [self addSubview:line];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), 20, SCREEN_WIDTH * 0.3, 30)];
        
        self.countLab = count;
        
        count.textColor = [UIColor colorWithRed:44/255. green:128/255. blue:232/255. alpha:1.];
        
        count.font = [UIFont systemFontOfSize:20];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), CGRectGetMaxY(count.frame), SCREEN_WIDTH * 0.3, 20)];
        
        self.statusLab = status;
        
        status.font = [UIFont systemFontOfSize:15];
        
        status.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:status];
        
        UILabel *product = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(count.frame), 10, SCREEN_WIDTH * 0.318, 15)];
        
        self.productLab = product;
        
        product.textColor = [UIColor darkTextColor];
        
        product.font = [UIFont systemFontOfSize:15];
        
        product.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:product];
        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(count.frame), CGRectGetMaxY(product.frame) + 5, SCREEN_WIDTH * 0.318, 15)];
        
        self.yuangongLab = yuan;
        
        yuan.textColor = [UIColor darkTextColor];
        
        yuan.font = [UIFont systemFontOfSize:14];
        
        yuan.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:yuan];
        
        UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(count.frame), CGRectGetMaxY(yuan.frame) + 5, SCREEN_WIDTH * 0.318, 15)];
        
        self.jineLab = jine;
        
        jine.textColor = [UIColor darkGrayColor];
        
        jine.font = [UIFont systemFontOfSize:13];
        
        jine.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:jine];
        
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    for (UIView *subView in self.subviews) {
        
        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            
            // 拿到subView之后再获取子控件

            // 因为上面删除按钮是第二个加的所以下标是1
            UIView *phoneConfirmationView = subView.subviews[0];
            //改背景颜色
            phoneConfirmationView.backgroundColor = [UIColor redColor];

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
