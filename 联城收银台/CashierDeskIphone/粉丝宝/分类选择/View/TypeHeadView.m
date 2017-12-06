//
//  TypeHeadView.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TypeHeadView.h"
#import "FFScrollView.h"
#import "FSB_Header.h"

@interface TypeHeadView ()<FFScrollViewDelegate>

// 轮播数组
@property (nonatomic, strong) NSArray *sourceArray;

@end

@implementation TypeHeadView

- (NSArray *)sourceArray {
    
    if (_sourceArray == nil) {
        
        _sourceArray = @[@"轮播1.png.jpg"];
        
    }
    
    return _sourceArray;
    
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        FFScrollView *scroll = [[FFScrollView alloc]initPageViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT * 0.2) views:self.sourceArray];
        
        scroll.pageViewDelegate = self;
        
        scroll.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
        scroll.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255. green:47/255. blue:46/255. alpha:1.];
        
        [self addSubview:scroll];
        
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(scroll.frame) + 20, SCREENWIDTH * 0.9, 140)];
        
        bg.backgroundColor = [UIColor colorWithRed:209/255. green:208/255. blue:208/255. alpha:1.];
        
        bg.layer.masksToBounds = YES;
        
        bg.layer.cornerRadius = 8;
        
        [self addSubview:bg];
        
        CGFloat iconW = bg.frame.size.height * 0.6;
        
        CGFloat fsbX = (bg.frame.size.width - iconW * 2) * 0.25;
        
        CGFloat fsbY = (bg.frame.size.height - iconW) * 0.3;
        
        UIButton *fsbBtn = [[UIButton alloc] initWithFrame:CGRectMake(fsbX, fsbY, iconW, iconW)];
        
        [fsbBtn setImage:[UIImage imageNamed:@"粉丝宝.png"] forState:0];
        
        [fsbBtn addTarget:self action:@selector(fsbClcik) forControlEvents:UIControlEventTouchUpInside];
        
        [bg addSubview:fsbBtn];
        
        UILabel *fsbLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(fsbBtn.frame) + 10, CGRectGetMaxX(fsbBtn.frame) + fsbX, 20)];
        
        fsbLab.text = @"粉丝宝";
        
        fsbLab.textColor = [UIColor blackColor];
        
        fsbLab.textAlignment = NSTextAlignmentCenter;
        
        fsbLab.font = [UIFont systemFontOfSize:15];
        
        [bg addSubview:fsbLab];
        
        
        CGFloat rhX = CGRectGetMaxX(fsbBtn.frame) + (bg.frame.size.width - iconW * 2) * 0.5;
        
        UIButton *rhBtn = [[UIButton alloc] initWithFrame:CGRectMake(rhX, fsbY, iconW, iconW)];
        
        [rhBtn setImage:[UIImage imageNamed:@"car(1).png"] forState:0];
        
        [rhBtn addTarget:self action:@selector(rhClcik) forControlEvents:UIControlEventTouchUpInside];
        
        [bg addSubview:rhBtn];
        
        UILabel *rhLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(fsbLab.frame), CGRectGetMaxY(fsbBtn.frame) + 10, CGRectGetMaxX(fsbBtn.frame) + fsbX, 20)];
        
        rhLab.text = @"养车宝";
        
        rhLab.textColor = [UIColor blackColor];
        
        rhLab.textAlignment = NSTextAlignmentCenter;
        
        rhLab.font = [UIFont systemFontOfSize:15];
        
        [bg addSubview:rhLab];
        
    }
    
    return self;
    
}

- (void)fsbClcik {

    if (self.FSBblock) {
        
        self.FSBblock();
        
    }
    
}

- (void)rhClcik {
    
    if (self.RHblock) {
        
        self.RHblock();
        
    }
    
}

@end
