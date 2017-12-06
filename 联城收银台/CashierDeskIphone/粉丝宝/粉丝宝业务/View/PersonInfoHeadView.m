//
//  PersonInfoHeadView.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "PersonInfoHeadView.h"
#import "FSB_Header.h"

@implementation PersonInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat titleX = SCREENWIDTH * 0.05;
        
        CGFloat titleY = 10;
        
        CGSize titleSize = [self sizeWithText:@"余额：" font:TitleFont maxSize:CGSizeMake(0,0)];
        
        CGFloat titleW = titleSize.width;
        
        CGFloat titleH = titleSize.height;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        
        title.text = @"余额：";
        
        title.font = TitleFont;
        
        title.textColor = TitleColor;
        
        [self addSubview:title];
        
        UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), titleY, SCREENWIDTH * 0.95 - CGRectGetMaxX(title.frame), titleH)];
        
        self.countLab = count;
        
        count.textAlignment = NSTextAlignmentLeft;
        
        count.font = TitleFont;
        
        count.textColor = [UIColor colorWithRed:255/255. green:53/255. blue:53/255. alpha:1.];
        
        [self addSubview:count];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame) + titleY, SCREENWIDTH, 10)];
        
        line1.backgroundColor = BGColor;
        
        [self addSubview:line1];
        
        CGSize phoneTitleSize = [self sizeWithText:@"商品名称：" font:TitleFont maxSize:CGSizeMake(0,0)];
        
        UILabel *phonetitle = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY + CGRectGetMaxY(line1.frame), phoneTitleSize.width, phoneTitleSize.height)];
        
        phonetitle.text = @"手机号：";
        
        phonetitle.font = TitleFont;
        
        phonetitle.textColor = TitleColor;
        
        [self addSubview:phonetitle];
        
        CGFloat fieldX = CGRectGetMaxX(phonetitle.frame) + 10;
        
        CGFloat fieldH = 30;
        
        CGFloat fieldY = (phoneTitleSize.height + 2 * titleY - fieldH) * 0.5 + CGRectGetMaxY(line1.frame);
        
        CGFloat fieldW = SCREENWIDTH * 0.95 - fieldX;
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, fieldY, fieldW, fieldH)];
        
        self.phoneField = field;
        
        field.font = TitleFont;
        
        field.textColor = TitleColor;
        
        field.placeholder = @"请输入手机号";
        
        field.keyboardType = UIKeyboardTypePhonePad;
        
        [self addSubview:field];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(phonetitle.frame) + titleY, SCREENWIDTH, 0.5)];
        
        line2.backgroundColor = LineColor;
        
        [self addSubview:line2];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.1, CGRectGetMaxY(line2.frame) + titleY, 50, 50)];
        
        self.iconImg = img;
        
        img.layer.masksToBounds = YES;
        
        img.layer.cornerRadius = 25;
        
        img.image = [UIImage imageNamed:@"FSB_头像.png"];
        
        [self addSubview:img];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(img.frame) + 20, CGRectGetMaxY(line2.frame) + titleY + 10, SCREENWIDTH * 0.95 - CGRectGetMaxX(img.frame) - 10, 30)];
        
        self.nameLab = name;
        
        name.textColor = TitleColor;
        
        name.font = TitleFont;
        
        name.textAlignment = NSTextAlignmentLeft;
        
        name.text = @"输入手机号检测";
        
        [self addSubview:name];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame) + titleY, SCREENWIDTH, 10)];
        
        line3.backgroundColor = BGColor;
        
        [self addSubview:line3];
        
        self.height = CGRectGetMaxY(line3.frame);
        
    }
    
    return self;
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

@end
