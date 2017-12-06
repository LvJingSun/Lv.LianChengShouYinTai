//
//  FSB_UpLoadFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/24.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_UpLoadFrame.h"
#import "FSB_TranInfoModel.h"
#import "FSB_Header.h"

@implementation FSB_UpLoadFrame

-(void)setTranModel:(FSB_TranInfoModel *)tranModel {

    _tranModel = tranModel;
    
    CGFloat margin = 10;
    
    CGFloat acounttitleX = SCREENWIDTH * 0.05;
    
    CGFloat acounttitleY = margin;
    
    CGFloat acounttitleH = 30;
    
    CGSize acounttitlesize = [self sizeWithText:@"账号：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    CGFloat acounttitleW = acounttitlesize.width;
    
    _acountTitleF = CGRectMake(acounttitleX, acounttitleY, acounttitleW, acounttitleH);
    
    CGFloat acountX = CGRectGetMaxX(_acountTitleF) + 10;
    
    CGFloat acountW = SCREENWIDTH * 0.95 - acountX;
    
    _acountF = CGRectMake(acountX, acounttitleY, acountW, acounttitleH);
    
    _acountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_acountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat nametitleY = margin + CGRectGetMaxY(_acountLineF);
    
    CGSize nametitlesize = [self sizeWithText:@"姓名：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _nameTitleF = CGRectMake(acounttitleX, nametitleY, nametitlesize.width, acounttitleH);
    
    CGFloat nameX = CGRectGetMaxX(_nameTitleF) + 10;
    
    CGFloat nameW = SCREENWIDTH * 0.95 - nameX;
    
    _nameF = CGRectMake(nameX, nametitleY, nameW, acounttitleH);
    
    _nameLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_nameTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat producttitleY = margin + CGRectGetMaxY(_nameLineF);
    
    CGSize producttitlesize = [self sizeWithText:@"商品名称：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _productTitleF = CGRectMake(acounttitleX, producttitleY, producttitlesize.width, acounttitleH);
    
    CGFloat productX = CGRectGetMaxX(_productTitleF) + 10;
    
    CGFloat productW = SCREENWIDTH * 0.95 - productX;
    
    _productF = CGRectMake(productX, producttitleY, productW, acounttitleH);
    
    _productLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_productTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat trantitleY = margin + CGRectGetMaxY(_productLineF);
    
    CGSize trantitlesize = [self sizeWithText:@"交易金额：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _tranCountTitleF = CGRectMake(acounttitleX, trantitleY, trantitlesize.width, acounttitleH);
    
    CGFloat tranX = CGRectGetMaxX(_tranCountTitleF) + 10;
    
    CGFloat tranW = SCREENWIDTH * 0.95 - tranX;
    
    _tranCountF = CGRectMake(tranX, trantitleY, tranW, acounttitleH);
    
    _tranCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_tranCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat redtitleY = margin + CGRectGetMaxY(_tranCountLineF);
    
    CGSize redtitlesize = [self sizeWithText:@"红包金额：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _redCountTitleF = CGRectMake(acounttitleX, redtitleY, redtitlesize.width, acounttitleH);
    
    CGFloat redX = CGRectGetMaxX(_redCountTitleF) + 10;
    
    CGFloat redW = SCREENWIDTH * 0.95 - redX;
    
    _redCountF = CGRectMake(redX, redtitleY, redW, acounttitleH);
    
    _redCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat copiestitleY = margin + CGRectGetMaxY(_redCountLineF);
    
    CGSize copiestitlesize = [self sizeWithText:@"红包份数：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _redCopiesTitleF = CGRectMake(acounttitleX, copiestitleY, copiestitlesize.width, acounttitleH);
    
    CGFloat copiesX = CGRectGetMaxX(_redCopiesTitleF) + 10;
    
    CGFloat copiesW = SCREENWIDTH * 0.95 - copiesX;
    
    _redCopiesF = CGRectMake(copiesX, copiestitleY, copiesW, acounttitleH);
    
    _redCopiesLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCopiesTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat goldtitleY = margin + CGRectGetMaxY(_redCopiesLineF);
    
    CGSize goldtitlesize = [self sizeWithText:@"金种子：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _goldCountTitleF = CGRectMake(acounttitleX, goldtitleY, goldtitlesize.width, acounttitleH);
    
    CGFloat goldX = CGRectGetMaxX(_goldCountTitleF) + 10;
    
    CGFloat goldW = SCREENWIDTH * 0.95 - goldX;
    
    _goldCountF = CGRectMake(goldX, goldtitleY, goldW, acounttitleH);
    
    _goldCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_goldCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat stafftitleY = margin + CGRectGetMaxY(_goldCountLineF);
    
    CGSize stafftitlesize = [self sizeWithText:@"促销员：" font:TitleFont maxSize:CGSizeMake(0, acounttitleH)];
    
    _staffTitleF = CGRectMake(acounttitleX, stafftitleY, stafftitlesize.width, acounttitleH);
    
    CGFloat staffX = CGRectGetMaxX(_staffTitleF) + 10;
    
    CGFloat staffW = SCREENWIDTH * 0.95 - staffX;
    
    _staffF = CGRectMake(staffX, stafftitleY, staffW, acounttitleH);
    
    _staffLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_staffTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGSize InvoiceTitleSize = [self sizeWithText:@"请上传发票" font:TitleFont maxSize:CGSizeMake(0,0)];
    
    CGFloat InvoicetitleX = SCREENWIDTH * 0.05;
    
    CGFloat InvoicetitleY = CGRectGetMaxY(_staffLineF) + margin;
    
    CGFloat InvoicetitleW = InvoiceTitleSize.width;
    
    CGFloat InvoicetitleH = InvoiceTitleSize.height;
    
    _InvoiceTitleF = CGRectMake(InvoicetitleX, InvoicetitleY, InvoicetitleW, InvoicetitleH);
    
    CGFloat AddBtnX = InvoicetitleX;
    
    CGFloat AddBtnH = 50;
    
    CGFloat AddBtnY = CGRectGetMaxY(_InvoiceTitleF) + margin;
    
    CGFloat AddBtnW = AddBtnH;
    
    _AddInvoiceBtnF = CGRectMake(AddBtnX, AddBtnY, AddBtnW, AddBtnH);
    
    CGFloat SureBtnX = SCREENWIDTH * 0.1;
    
    CGFloat SureBtnH = 45;
    
    CGFloat SureBtnY = CGRectGetMaxY(_AddInvoiceBtnF) + margin + 40;
    
    CGFloat SureBtnW = SCREENWIDTH * 0.8;
    
    _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_AddInvoiceBtnF) + margin;
    
    CGFloat bgH = CGRectGetMaxY(_SureBtnF) + margin - bgY;
    
    CGFloat bgW = SCREENWIDTH;
    
    _SureBtnBGViewF = CGRectMake(bgX, bgY, bgW, bgH);
    
    _height = CGRectGetMaxY(_SureBtnBGViewF);
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

@end
