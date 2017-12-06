//
//  Choose_CopiesFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Choose_CopiesFrame.h"
#import "Choose_CopiesModel.h"
#import "FSB_Header.h"

@implementation Choose_CopiesFrame

-(void)setCopiesmodel:(Choose_CopiesModel *)copiesmodel {

    _copiesmodel = copiesmodel;
    
    CGFloat viewWidth = SCREENWIDTH * 0.6 * 0.9;
    
    CGFloat nameX = viewWidth * 0.05;
    
    CGFloat nameY = 5;
    
    CGFloat nameW = viewWidth - 15 - nameX - 10;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_nameF) + 5, viewWidth, 1);
    
    CGFloat iconX = CGRectGetMaxX(_nameF);
    
    CGFloat iconW = 15;
    
    CGFloat iconH = iconW;
    
    CGFloat iconY = (CGRectGetMaxY(_lineF) - iconH) * 0.5;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
