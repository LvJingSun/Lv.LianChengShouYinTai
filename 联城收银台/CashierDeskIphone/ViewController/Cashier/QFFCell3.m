//
//  QFFCell3.m
//  CashierDeskIphone
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "QFFCell3.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation QFFCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *xinxiView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05, 0, SCREEN_WIDTH * 0.9, 100)];
        
        xinxiView.backgroundColor = [UIColor whiteColor];
        
        xinxiView.layer.cornerRadius = 5;
        
        [self addSubview:xinxiView];
        
        self.height = CGRectGetMaxY(xinxiView.frame) + 10;
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, xinxiView.frame.size.width - 20, 20)];
        
        lab.text = @"对方信息:";
        
        lab.textColor = [UIColor lightGrayColor];
        
        [xinxiView addSubview:lab];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lab.frame) + 10, 50, 50)];
        
        self.iconImageView = imageview;
        
        imageview.image = [UIImage imageNamed:@"moren.png"];
        
        [self setLayer:imageview andcornerRadius:5];
        
        [xinxiView addSubview:imageview];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + 10, CGRectGetMaxY(lab.frame) + 20, xinxiView.frame.size.width - 80, 30)];
        
        self.userNameLab = nameLab;
        
        nameLab.text = @"----";
        
        [xinxiView addSubview:nameLab];
        
    }
    
    return self;
    
}

//设置头像圆形
-(void)setLayer:(UIView *)View andcornerRadius:(CGFloat)cornerRadius;{
    View.layer.masksToBounds = YES;
    View.layer.cornerRadius = View.frame.size.width/2; //圆角（圆形)
    //防止掉帧（列表不卡了）
    View.layer.shouldRasterize = YES;
    View.layer.rasterizationScale = [UIScreen mainScreen].scale;
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
