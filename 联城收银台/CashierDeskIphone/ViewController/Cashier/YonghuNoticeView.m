//
//  YonghuNoticeView.m
//  驾驶舱
//
//  Created by mac on 2016/12/21.
//  Copyright © 2016年 lvjing. All rights reserved.
//

#import "YonghuNoticeView.h"
//背景色
#define BGColor [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.]
//屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
//线的颜色
#define LineColor [UIColor colorWithRed:237/255. green:237/255. blue:237/255. alpha:1.]
//浅字体颜色
#define QIANTextColor [UIColor colorWithRed:172/255. green:176/255. blue:182/255. alpha:1.]


@interface YonghuNoticeView ()

@property (nonatomic, weak) UILabel *noticeLab;

@end

@implementation YonghuNoticeView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = BGColor;
        
        UILabel *upline = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
        
        upline.backgroundColor = LineColor;
        
        [self addSubview:upline];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(upline.frame), SCREENWIDTH * 0.9, 29)];
        
        lab.textColor = QIANTextColor;
        
        self.noticeLab = lab;
        
        lab.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:lab];
        
        UILabel *boline = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame), SCREENWIDTH, 0.5)];
        
        boline.backgroundColor = LineColor;
        
        [self addSubview:boline];
        
        self.height = CGRectGetMaxY(boline.frame);
        
    }
    
    return self;
    
}

-(void)setTitletext:(NSString *)titletext {

    _titletext = titletext;
    
    [self setContent];
    
}

- (void)setContent {

    self.noticeLab.text = self.titletext;
    
}

@end
