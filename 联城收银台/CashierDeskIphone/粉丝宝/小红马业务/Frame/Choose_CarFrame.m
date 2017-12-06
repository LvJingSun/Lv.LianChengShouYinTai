//
//  Choose_CarFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Choose_CarFrame.h"
#import "ChooseCarModel.h"
#import "FSB_Header.h"

@implementation Choose_CarFrame

-(void)setCarmodel:(ChooseCarModel *)carmodel {

    _carmodel = carmodel;
    
    CGFloat viewWidth = SCREENWIDTH * 0.6 * 0.9;
    
    CGFloat iconX = 0;
    
    CGFloat iconY = 10;
    
    CGFloat iconW = 40;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_iconF) + 10, viewWidth, 1);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 5;
    
    CGFloat nameY = 10;
    
    CGFloat nameW = viewWidth - 15 - nameX - 10;
    
    CGFloat nameH = 20;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat plateX = nameX;
    
    CGFloat plateY = CGRectGetMaxY(_nameF) + 5;
    
    CGFloat plateW = nameW;
    
    CGFloat plateH = 15;
    
    _plateF = CGRectMake(plateX, plateY, plateW, plateH);
    
    CGFloat chooseX = CGRectGetMaxX(_nameF);
    
    CGFloat chooseW = 15;
    
    CGFloat chooseH = chooseW;
    
    CGFloat chooseY = (CGRectGetMaxY(_lineF) - chooseW) * 0.5;
    
    _chooseF = CGRectMake(chooseX, chooseY, chooseW, chooseH);
    
    _height = CGRectGetMaxY(_lineF);
    
}

@end
