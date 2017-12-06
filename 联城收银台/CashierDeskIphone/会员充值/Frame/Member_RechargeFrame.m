//
//  Member_RechargeFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Member_RechargeFrame.h"
#import "FSB_Header.h"
#import "Member_RechargeModel.h"

@implementation Member_RechargeFrame

-(void)setRechargeModel:(Member_RechargeModel *)rechargeModel {
    
    _rechargeModel = rechargeModel;
    
    CGFloat phoneX = SCREENWIDTH * 0.05;
    
    CGFloat phoneY = 15;
    
    CGFloat phoneW = SCREENWIDTH * 0.9;
    
    CGFloat phoneH = 50;
    
    _phoneF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    CGFloat iconX = SCREENWIDTH * 0.05;
    
    CGFloat iconY = CGRectGetMaxY(_phoneF) + 30;
    
    CGFloat iconW = 70;
    
    CGFloat iconH = iconW;
    
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameX = CGRectGetMaxX(_iconF) + 10;
    
    CGFloat nameY = iconY;
    
    CGFloat nameW = SCREENWIDTH * 0.95 - nameX;
    
    CGFloat nameH = 30;
    
    _nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat balanceX = nameX;
    
    CGFloat balanceY = CGRectGetMaxY(_nameF) + 10;
    
    CGFloat balanceW = nameW;
    
    CGFloat balanceH = nameH;
    
    _balanceF = CGRectMake(balanceX, balanceY, balanceW, balanceH);
    
    CGFloat typeX = SCREENWIDTH * 0.05;
    
    CGFloat typeY = CGRectGetMaxY(_iconF) + 15;
    
    CGFloat typeW = 70;
    
    CGFloat typeH = 25;
    
    _typeTitleF = CGRectMake(typeX, typeY, typeW, typeH);
    
    CGFloat yueX = CGRectGetMaxX(_typeTitleF) + 10;
    
    CGFloat yueY = typeY;
    
    CGFloat yueW = (SCREENWIDTH * 0.95 - yueX) * 0.5;
    
    CGFloat yueH = typeH;
    
    _yueRechargeF = CGRectMake(yueX, yueY, yueW, yueH);
    
    CGFloat jinfenX = CGRectGetMaxX(_yueRechargeF);
    
    _jifenRechargeF = CGRectMake(jinfenX, yueY, yueW, yueH);
    
    CGFloat countTitleY = CGRectGetMaxY(_typeTitleF) + 15;
    
    _countTitleF = CGRectMake(typeX, countTitleY, typeW, typeH);
    
    CGFloat countX = yueX;
    
    CGFloat countY = CGRectGetMaxY(_typeTitleF) + 10;
    
    CGFloat countW = SCREENWIDTH * 0.95 - countX;
    
    CGFloat countH = typeH + 10;
    
    _countF = CGRectMake(countX, countY, countW, countH);
    
    CGFloat beizhuTitleY = CGRectGetMaxY(_countTitleF) + 15;
    
    _beizhuTitleF = CGRectMake(typeX, beizhuTitleY, typeW, typeH);
    
    CGFloat beizhuY = beizhuTitleY - 5;
    
    _beizhuF = CGRectMake(countX, beizhuY, countW, countH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_phoneF) + 15;
    
    CGFloat bgW = SCREENWIDTH;
    
    CGFloat bgH = CGRectGetMaxY(_beizhuTitleF) + 15 - bgY;
    
    _bgF = CGRectMake(bgX, bgY, bgW, bgH);
    
    CGFloat sureX = SCREENWIDTH * 0.05;
    
    CGFloat sureY = CGRectGetMaxY(_bgF) + 15;
    
    CGFloat sureW = SCREENWIDTH * 0.9;
    
    CGFloat sureH = 50;
    
    _sureF = CGRectMake(sureX, sureY, sureW, sureH);
    
    _height = CGRectGetMaxY(_sureF);
    
}

@end
