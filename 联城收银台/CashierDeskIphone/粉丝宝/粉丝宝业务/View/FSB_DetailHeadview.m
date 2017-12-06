//
//  FSB_DetailHeadview.m
//  CashierDeskIphone
//
//  Created by mac on 2017/7/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailHeadview.h"
#import "FSB_Header.h"

@implementation FSB_DetailHeadview

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.1, 25, SCREENWIDTH * 0.4, 40)];
        
        self.nameLab = name;
        
        name.font = [UIFont systemFontOfSize:20];
        
        name.textColor = [UIColor blackColor];
        
        [self addSubview:name];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame) + 25, SCREENWIDTH, 9)];
        
        self.lineImg = line;
        
        line.image = [UIImage imageNamed:@"fsb_线.png"];
        
        [self addSubview:line];
        
        self.height = CGRectGetMaxY(line.frame);
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), 10, SCREENWIDTH * 0.4, 30)];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:23];
        
        count.textColor = NAVTextColor;
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), CGRectGetMaxY(count.frame) + 10, SCREENWIDTH * 0.3, 30)];
        
        self.statusLab = status;
        
        status.font = [UIFont systemFontOfSize:16];
        
        status.textAlignment = NSTextAlignmentRight;
        
        status.textColor = [UIColor colorWithRed:95/255. green:93/255. blue:93/255. alpha:1.];
        
        [self addSubview:status];
        
    }
    
    return self;
    
}

@end
