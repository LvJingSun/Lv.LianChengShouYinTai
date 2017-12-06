//
//  SureView.m
//  CashierDeskIphone
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "SureView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation SureView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.8];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.1, SCREEN_HEIGHT * 0.25, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT * 0.5)];
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        bgview.layer.cornerRadius = 5;
        
        [self addSubview:bgview];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, bgview.frame.size.width, 25)];
        
        title.text = @"确认充值";
        
        title.font = [UIFont systemFontOfSize:20];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [bgview addSubview:title];
        
        UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, 45, bgview.frame.size.width * 0.9, (bgview.frame.size.height * 0.8 - 95) * 0.2)];
        
        self.phoneLab = phone;
        
        phone.font = [UIFont systemFontOfSize:18];
        
        phone.textColor = [UIColor darkGrayColor];
        
        [bgview addSubview:phone];
        
        UILabel *product = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, CGRectGetMaxY(phone.frame) + 10, bgview.frame.size.width * 0.9, (bgview.frame.size.height * 0.8 - 95) * 0.2)];
        
        self.productLab = product;
        
        product.font = [UIFont systemFontOfSize:18];
        
        product.textColor = [UIColor darkGrayColor];
        
        [bgview addSubview:product];
        
        UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, CGRectGetMaxY(product.frame) + 10, bgview.frame.size.width * 0.9, (bgview.frame.size.height * 0.8 - 95) * 0.2)];
        
        self.jineLab = jine;
        
        jine.font = [UIFont systemFontOfSize:18];
        
        jine.textColor = [UIColor darkGrayColor];
        
        [bgview addSubview:jine];
        
        UILabel *zhouqi = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, CGRectGetMaxY(jine.frame) + 10, bgview.frame.size.width * 0.9, (bgview.frame.size.height * 0.8 - 95) * 0.2)];
        
        self.zhouqiLab = zhouqi;
        
        zhouqi.font = [UIFont systemFontOfSize:18];
        
        zhouqi.textColor = [UIColor darkGrayColor];
        
        [bgview addSubview:zhouqi];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(bgview.frame.size.width * 0.1, CGRectGetMaxY(zhouqi.frame) + 10, bgview.frame.size.width * 0.9, (bgview.frame.size.height * 0.8 - 95) * 0.2)];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:18];
        
        count.textColor = [UIColor darkGrayColor];
        
        [bgview addSubview:count];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, bgview.frame.size.height * 0.8, bgview.frame.size.width, 0.5)];
        
        line.backgroundColor = [UIColor lightGrayColor];
        
        [bgview addSubview:line];
        
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), bgview.frame.size.width * 0.5, bgview.frame.size.height * 0.2 - 0.5)];
        
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancleBtn setTitleColor:[UIColor colorWithRed:58/255. green:139/255. blue:212/255. alpha:1.] forState:UIControlStateNormal];
        
        [cancleBtn addTarget:self action:@selector(cncleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:cancleBtn];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancleBtn.frame), CGRectGetMaxY(line.frame), bgview.frame.size.width * 0.5, bgview.frame.size.height * 0.2 - 0.5)];
        
        self.sureBtn = sureBtn;
        
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        [sureBtn setTitleColor:[UIColor colorWithRed:58/255. green:139/255. blue:212/255. alpha:1.] forState:UIControlStateNormal];
        
        [sureBtn addTarget:self action:@selector(cncleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [bgview addSubview:sureBtn];
        
    }
    
    return self;
    
}

- (void)cncleBtnClicked {

    if (self) {
        
        [self removeFromSuperview];
        
    }
    
}

@end
