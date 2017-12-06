//
//  FSB_InPutFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_InPutFrame.h"
#import "FSB_TranInfoModel.h"
#import "FSB_Header.h"

@implementation FSB_InPutFrame

-(void)setTranModel:(FSB_TranInfoModel *)tranModel {

    _tranModel = tranModel;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

- (CGFloat)getCellHeight {
    
    if ([self.tranModel.redType isEqualToString:@"1"]) {
        
        CGFloat margin = 10;
        
        CGFloat producttitleX = SCREENWIDTH * 0.05;
        
        CGFloat producttitleY = margin;
        
        CGFloat producttitleH = 30;
        
        CGSize producttitlesize = [self sizeWithText:@"商品名称：" font:TitleFont maxSize:CGSizeMake(0, producttitleH)];
        
        CGFloat producttitleW = producttitlesize.width;
        
        _productTitleF = CGRectMake(producttitleX, producttitleY, producttitleW, producttitleH);
        
        CGFloat productX = CGRectGetMaxX(_productTitleF) + 10;
        
        CGFloat productW = SCREENWIDTH * 0.95 - productX;
        
        _productF = CGRectMake(productX, producttitleY, productW, producttitleH);
        
        _productLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_productTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        
        CGFloat trancounttitleY = margin + CGRectGetMaxY(_productLineF);
        
        _tranCountTitleF = CGRectMake(producttitleX, trancounttitleY, producttitleW, producttitleH);
        
        _tranCountF = CGRectMake(productX, trancounttitleY, productW, producttitleH);
        
        _tranCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_tranCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redTypeTitleY = margin + CGRectGetMaxY(_tranCountLineF);
        
        _redTypeTitleF = CGRectMake(producttitleX, redTypeTitleY, producttitleW, producttitleH);
        
        CGFloat type_merchantX = CGRectGetMaxX(_redTypeTitleF) + 20;
        
        CGFloat radioW = (SCREENWIDTH * 0.95 - type_merchantX) * 0.5;
        
        CGFloat radioH = 30;
        
        CGFloat type_merchantY = (CGRectGetMaxY(_redTypeTitleF) + margin - CGRectGetMaxY(_tranCountLineF) - radioH) * 0.5 + CGRectGetMaxY(_tranCountLineF);
        
        _type_merchantF = CGRectMake(type_merchantX, type_merchantY, radioW, radioH);
        
        CGFloat type_pingtaiX = CGRectGetMaxX(_type_merchantF);
        
        _type_pingtaiF = CGRectMake(type_pingtaiX, type_merchantY, radioW, radioH);
        
        CGFloat noticeX = SCREENWIDTH * 0.1;
        
        CGFloat noticeY = CGRectGetMaxY(_redTypeTitleF) + margin;
        
        CGFloat noticeW = SCREENWIDTH * 0.9;
        
        CGFloat noticeH = 15;
        
        _noticeF = CGRectMake(noticeX, noticeY, noticeW, noticeH);
        
        CGFloat merchant_huiyuankaY = CGRectGetMaxY(_noticeF) + margin;
        
        _merchant_huiyuankaF = CGRectMake(SCREENWIDTH * 0.1, merchant_huiyuankaY, SCREENWIDTH * 0.8, 30);
        
        CGFloat merchant_tixianY = CGRectGetMaxY(_merchant_huiyuankaF) + margin;
        
        _merchant_tixianF = CGRectMake(SCREENWIDTH * 0.1, merchant_tixianY, SCREENWIDTH * 0.8, 30);
        
        _redTypeLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_merchant_tixianF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redcounttitleY = margin + CGRectGetMaxY(_redTypeLineF);
        
        _redCountTitleF = CGRectMake(producttitleX, redcounttitleY, producttitleW, producttitleH);
        
        _redCountF = CGRectMake(productX, redcounttitleY, productW, producttitleH);
        
        _redCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redcopiestitleY = margin + CGRectGetMaxY(_redCountLineF);
        
        _redCopiesTitleF = CGRectMake(producttitleX, redcopiestitleY, producttitleW, producttitleH);
        
        _redCopiesF = CGRectMake(productX, redcopiestitleY, productW, producttitleH);
        
        _redCopiesLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCopiesTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat jifencounttitleY = margin + CGRectGetMaxY(_redCopiesLineF);

        _jifenCountTitleF = CGRectMake(producttitleX, jifencounttitleY, producttitleW, producttitleH);

        _jifenCountF = CGRectMake(productX, jifencounttitleY, productW, producttitleH);

        _jifenCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_jifenCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat stafftitleY = margin + CGRectGetMaxY(_jifenCountLineF);
        
        _staffTitleF = CGRectMake(producttitleX, stafftitleY, producttitleW, producttitleH);
        
        _staffF = CGRectMake(productX, stafftitleY, productW, producttitleH);
        
        _staffLineF = CGRectMake(0, CGRectGetMaxY(_staffTitleF) + margin, SCREENWIDTH, 0.5);
        
        CGFloat SureBtnX = SCREENWIDTH * 0.1;
        
        CGFloat SureBtnH = 45;
        
        CGFloat SureBtnY = CGRectGetMaxY(_staffLineF) + margin + 20;
        
        CGFloat SureBtnW = SCREENWIDTH * 0.8;
        
        _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
        
        CGFloat bgX = 0;
        
        CGFloat bgY = CGRectGetMaxY(_staffLineF);
        
        CGFloat bgH = CGRectGetMaxY(_SureBtnF) + margin - bgY;
        
        CGFloat bgW = SCREENWIDTH;
        
        _SureBtnBGViewF = CGRectMake(bgX, bgY, bgW, bgH);
        
        _height = CGRectGetMaxY(_SureBtnBGViewF);
        
        return _height;
        
    }else if ([self.tranModel.redType isEqualToString:@"0"]) {
        
        CGFloat margin = 10;
        
        CGFloat producttitleX = SCREENWIDTH * 0.05;
        
        CGFloat producttitleY = margin;
        
        CGFloat producttitleH = 30;
        
        CGSize producttitlesize = [self sizeWithText:@"商品名称：" font:TitleFont maxSize:CGSizeMake(0, producttitleH)];
        
        CGFloat producttitleW = producttitlesize.width;
        
        _productTitleF = CGRectMake(producttitleX, producttitleY, producttitleW, producttitleH);
        
        CGFloat productX = CGRectGetMaxX(_productTitleF) + 10;
        
        CGFloat productW = SCREENWIDTH * 0.95 - productX;
        
        _productF = CGRectMake(productX, producttitleY, productW, producttitleH);
        
        _productLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_productTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat trancounttitleY = margin + CGRectGetMaxY(_productLineF);
        
        _tranCountTitleF = CGRectMake(producttitleX, trancounttitleY, producttitleW, producttitleH);
        
        _tranCountF = CGRectMake(productX, trancounttitleY, productW, producttitleH);
        
        _tranCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_tranCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redTypeTitleY = margin + CGRectGetMaxY(_tranCountLineF);
        
        _redTypeTitleF = CGRectMake(producttitleX, redTypeTitleY, producttitleW, producttitleH);
        
        CGFloat type_merchantX = CGRectGetMaxX(_redTypeTitleF) + 20;
        
        CGFloat radioW = (SCREENWIDTH * 0.95 - type_merchantX) * 0.5;
        
        CGFloat radioH = 30;
        
        CGFloat type_merchantY = (CGRectGetMaxY(_redTypeTitleF) + margin - CGRectGetMaxY(_tranCountLineF) - radioH) * 0.5 + CGRectGetMaxY(_tranCountLineF);
        
        _type_merchantF = CGRectMake(type_merchantX, type_merchantY, radioW, radioH);
        
        CGFloat type_pingtaiX = CGRectGetMaxX(_type_merchantF);
        
        _type_pingtaiF = CGRectMake(type_pingtaiX, type_merchantY, radioW, radioH);
        
        _redTypeLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redTypeTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redcounttitleY = margin + CGRectGetMaxY(_redTypeLineF);
        
        _redCountTitleF = CGRectMake(producttitleX, redcounttitleY, producttitleW, producttitleH);
        
        _redCountF = CGRectMake(productX, redcounttitleY, productW, producttitleH);
        
        _redCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat redcopiestitleY = margin + CGRectGetMaxY(_redCountLineF);
        
        _redCopiesTitleF = CGRectMake(producttitleX, redcopiestitleY, producttitleW, producttitleH);
        
        _redCopiesF = CGRectMake(productX, redcopiestitleY, productW, producttitleH);
        
        _redCopiesLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCopiesTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat goldcounttitleY = margin + CGRectGetMaxY(_redCopiesLineF);
        
        _goldCountTitleF = CGRectMake(producttitleX, goldcounttitleY, producttitleW, producttitleH);
        
        _goldCountF = CGRectMake(productX, goldcounttitleY, productW, producttitleH);
        
        _goldCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_goldCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
        
        CGFloat stafftitleY = margin + CGRectGetMaxY(_goldCountLineF);
        
        _staffTitleF = CGRectMake(producttitleX, stafftitleY, producttitleW, producttitleH);
        
        _staffF = CGRectMake(productX, stafftitleY, productW, producttitleH);
        
        _staffLineF = CGRectMake(0, CGRectGetMaxY(_staffTitleF) + margin, SCREENWIDTH, 0.5);
        
        CGFloat SureBtnX = SCREENWIDTH * 0.1;
        
        CGFloat SureBtnH = 45;
        
        CGFloat SureBtnY = CGRectGetMaxY(_staffLineF) + margin + 20;
        
        CGFloat SureBtnW = SCREENWIDTH * 0.8;
        
        _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
        
        CGFloat bgX = 0;
        
        CGFloat bgY = CGRectGetMaxY(_staffLineF);
        
        CGFloat bgH = CGRectGetMaxY(_SureBtnF) + margin - bgY;
        
        CGFloat bgW = SCREENWIDTH;
        
        _SureBtnBGViewF = CGRectMake(bgX, bgY, bgW, bgH);
        
        _height = CGRectGetMaxY(_SureBtnBGViewF);
        
        return _height;
        
    }else {
        
        return 0;
        
    }
    
}

@end
