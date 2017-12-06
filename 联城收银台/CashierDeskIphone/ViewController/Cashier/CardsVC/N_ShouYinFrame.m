//
//  N_ShouYinFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "N_ShouYinFrame.h"
#import "N_ShouYinModel.h"
#import "FSB_Header.h"

@implementation N_ShouYinFrame

-(void)setRecordModel:(N_ShouYinModel *)recordModel {
    
    _recordModel = recordModel;
    
    CGFloat typeX = SCREENWIDTH * 0.05;
    
    CGFloat typeY = 10;
    
    CGFloat typeW = SCREENWIDTH * 0.45;
    
    CGFloat typeH = 20;
    
    _typeF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat dateX = typeX;
    
    CGFloat dateY = CGRectGetMaxY(_typeF) + 5;
    
    CGFloat dateW = typeW;
    
    CGFloat dateH = 10;
    
    _dateF = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat countX = SCREENWIDTH * 0.5;
    
    CGFloat countY = typeY;
    
    CGFloat countW = SCREENWIDTH * 0.45;
    
    CGFloat countH = 20;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat styleX = countX;
    
    CGFloat styleY = CGRectGetMaxY(_countF) + 5;
    
    CGFloat styleW = countW;
    
    CGFloat styleH = 10;
    
    _statusF = CGRectMake(styleX, styleY, styleW, styleH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_dateF) + 9.5;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
