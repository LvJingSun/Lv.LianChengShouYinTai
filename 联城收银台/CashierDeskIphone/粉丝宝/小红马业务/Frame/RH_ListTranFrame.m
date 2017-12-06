//
//  RH_ListTranFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ListTranFrame.h"
#import "FSB_Header.h"
#import "RH_ListTranModel.h"

@implementation RH_ListTranFrame

-(void)setListModel:(RH_ListTranModel *)listModel {

    _listModel = listModel;
    
    CGFloat nameX = SCREENWIDTH * 0.05;
    
    CGFloat nameY = 15;
    
    CGFloat nameW = SCREENWIDTH * 0.45;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat proX = nameX;
    
    CGFloat proY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat proW = nameW;
    
    CGFloat proH = 20;
    
    _productF = CGRectMake(proX, proY, proW, proH);
    
    CGFloat lineX = 0;
    
    CGFloat lineY = CGRectGetMaxY(_productF) + 15;
    
    CGFloat lineW = SCREENWIDTH;
    
    CGFloat lineH = 0.5;
    
    _lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    _height = CGRectGetMaxY(_lineF);
    
    CGFloat countX = SCREENWIDTH * 0.5;
    
    CGFloat countY = nameY;
    
    CGFloat countW = SCREENWIDTH * 0.45;
    
    CGFloat countH = nameH;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat timeX = countX;
    
    CGFloat timeY = proY;
    
    CGFloat timeW = countW;
    
    CGFloat timeH = proH;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
}

@end
