//
//  RH_InPutFrame.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InPutFrame.h"
#import "RH_TranInfoModel.h"
#import "FSB_Header.h"

@implementation RH_InPutFrame

-(void)setTranModel:(RH_TranInfoModel *)tranModel {

    _tranModel = tranModel;
    
    CGFloat margin = 10;
    
    CGFloat producttitleX = SCREENWIDTH * 0.05;
    
    CGFloat producttitleY = margin;
    
    CGFloat producttitleH = 30;
    
    CGSize producttitlesize = [self sizeWithText:@"车辆信息：" font:TitleFont maxSize:CGSizeMake(0, producttitleH)];
    
    CGFloat producttitleW = producttitlesize.width;
    
    _productTitleF = CGRectMake(producttitleX, producttitleY, producttitleW, producttitleH);
    
    CGFloat productX = CGRectGetMaxX(_productTitleF) + 10;
    
    CGFloat productW = SCREENWIDTH * 0.95 - productX;
    
    _productF = CGRectMake(productX, producttitleY, productW, producttitleH);
    
    _productLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_productTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat redcounttitleY = margin + CGRectGetMaxY(_productLineF);
    
    _redCountTitleF = CGRectMake(producttitleX, redcounttitleY, producttitleW, producttitleH);
    
    _redCountF = CGRectMake(productX, redcounttitleY, productW, producttitleH);
    
    _redCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat redcopiestitleY = margin + CGRectGetMaxY(_redCountLineF);
    
    _redCopiesTitleF = CGRectMake(producttitleX, redcopiestitleY, producttitleW, producttitleH);
    
    _redCopiesF = CGRectMake(productX, redcopiestitleY, productW, producttitleH);
    
    _redCopiesLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redCopiesTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat redproportiontitleY = margin + CGRectGetMaxY(_redCopiesLineF);
    
    _redProportionTitleF = CGRectMake(producttitleX, redproportiontitleY, producttitleW, producttitleH);
    
    _redProportionF = CGRectMake(productX, redproportiontitleY, productW, producttitleH);
    
    _redProportionLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_redProportionTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
    CGFloat goldcounttitleY = margin + CGRectGetMaxY(_redProportionLineF);
    
    _goldCountTitleF = CGRectMake(producttitleX, goldcounttitleY, producttitleW, producttitleH);
    
    _goldCountF = CGRectMake(productX, goldcounttitleY, productW, producttitleH);
    
    _goldCountLineF = CGRectMake(SCREENWIDTH * 0.05, CGRectGetMaxY(_goldCountTitleF) + margin, SCREENWIDTH * 0.95, 0.5);
    
//    CGFloat stafftitleY = margin + CGRectGetMaxY(_goldCountLineF);
    
//    _staffTitleF = CGRectMake(producttitleX, stafftitleY, producttitleW, producttitleH);
//    
//    _staffF = CGRectMake(productX, stafftitleY, productW, producttitleH);
//    
//    _staffLineF = CGRectMake(0, CGRectGetMaxY(_staffTitleF) + margin, SCREENWIDTH, 0.5);
    
    CGFloat SureBtnX = SCREENWIDTH * 0.1;
    
    CGFloat SureBtnH = 45;
    
    CGFloat SureBtnY = CGRectGetMaxY(_goldCountLineF) + margin + 20;
    
    CGFloat SureBtnW = SCREENWIDTH * 0.8;
    
    _SureBtnF = CGRectMake(SureBtnX, SureBtnY, SureBtnW, SureBtnH);
    
    CGFloat bgX = 0;
    
    CGFloat bgY = CGRectGetMaxY(_goldCountLineF);
    
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
