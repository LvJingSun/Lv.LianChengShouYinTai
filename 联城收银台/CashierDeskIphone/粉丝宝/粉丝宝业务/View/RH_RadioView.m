//
//  RH_RadioView.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_RadioView.h"

@implementation RH_RadioView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, (frame.size.height - 15) * 0.5, 15, 15)];
        
        self.btn = btn;
        
        [self addSubview:btn];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame) + 3, 0, frame.size.width - CGRectGetMaxX(btn.frame) - 3, frame.size.height)];
        
        self.title = title;
        
        title.textColor = [UIColor colorWithRed:18/255.f green:18/255.f blue:18/255.f alpha:1.0];
        
        title.font = [UIFont systemFontOfSize:14];
        
        title.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:title];
        
    }
    
    return self;
    
}

@end
