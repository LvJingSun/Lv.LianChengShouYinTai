//
//  N_homeHeadView.m
//  CashierDeskIphone
//
//  Created by mac on 2017/3/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_homeHeadView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation N_homeHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIButton *saomiao = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, 20, SCREEN_WIDTH * 0.35, SCREEN_WIDTH * 0.35)];
        
        self.saomiaoBtn = saomiao;
        
        saomiao.layer.masksToBounds = YES;
        
        saomiao.layer.cornerRadius = saomiao.frame.size.width * 0.5;
        
        [saomiao setImage:[UIImage imageNamed:@"icon_cashier_quick.png"] forState:0];
        
        [self addSubview:saomiao];
        
        UIButton *shouyin = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.55, 20, SCREEN_WIDTH * 0.35, SCREEN_WIDTH * 0.35)];
        
        self.shouyinBtn = shouyin;
        
        shouyin.layer.masksToBounds = YES;
        
        shouyin.layer.cornerRadius = saomiao.frame.size.width * 0.5;
        
        [shouyin setImage:[UIImage imageNamed:@"icon_cashier_manually.png"] forState:0];
        
        [self addSubview:shouyin];
        
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(saomiao.frame) + 10, SCREEN_WIDTH * 0.5, 40)];
        
        title1.text = @"快速扫描";
        
        title1.textColor = [UIColor blackColor];
        
        title1.font = [UIFont systemFontOfSize:18];
        
        title1.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title1];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, CGRectGetMaxY(saomiao.frame) + 10, SCREEN_WIDTH * 0.5, 40)];
        
        title2.text = @"手动收银";
        
        title2.textColor = [UIColor blackColor];
        
        title2.font = [UIFont systemFontOfSize:18];
        
        title2.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title2];
        
        CGSize titleSize = [self sizeWithText:@"会员出示二维码批量快速收银" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH * 0.35, 0)];
        
        UILabel *notice1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, CGRectGetMaxY(title1.frame), SCREEN_WIDTH * 0.35, titleSize.height)];
        
        notice1.text = @"会员出示二维码批量快速收银";
        
        notice1.font = [UIFont systemFontOfSize:15];
        
        notice1.textAlignment = NSTextAlignmentCenter;
        
        notice1.textColor = [UIColor lightGrayColor];
        
//        notice1.backgroundColor = [UIColor lightGrayColor];
        
        notice1.numberOfLines = 0;
        
        [self addSubview:notice1];
        
        CGSize titleSize2 = [self sizeWithText:@"会员出示KEY值、券券、会员卡、手机号手动录入验证" font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH * 0.35, 0)];
        
        UILabel *notice2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.55, CGRectGetMaxY(title2.frame), SCREEN_WIDTH * 0.35, titleSize2.height)];
        
        notice2.text = @"会员出示KEY值、券券、会员卡、手机号手动录入验证";
        
        notice2.font = [UIFont systemFontOfSize:15];
        
        notice2.textAlignment = NSTextAlignmentCenter;
        
        notice2.textColor = [UIColor lightGrayColor];
        
//        notice2.backgroundColor = [UIColor lightGrayColor];
        
        notice2.numberOfLines = 0;
        
        [self addSubview:notice2];
        
        self.height = CGRectGetMaxY(notice2.frame) + 20;
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
