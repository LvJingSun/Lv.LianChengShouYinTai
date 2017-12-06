//
//  checkBox.m
//  CashierDeskIphone
//
//  Created by mac on 13-9-7.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "checkBox.h"

@implementation checkBox
@synthesize checkImg = _checkImg;
@synthesize unCheckImg = _unCheckImg;
@synthesize isCheck = _isCheck;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initCheckImg:(UIImage*)checkImg UnCheckImg:(UIImage*)unCheckImg wihtCheckStatus:(BOOL)check;
{
    _isCheck = check;
    self.checkImg = checkImg;
    self.unCheckImg = unCheckImg;
    if (_isCheck) {
        [self setImage:_checkImg forState:UIControlStateNormal];
    }else
    {
        [self setImage:_unCheckImg forState:UIControlStateNormal];
    }
}

- (void)setCheckBox:(BOOL)checkStatus
{
    _isCheck = checkStatus;
    if (_isCheck) {
        [self setImage:_checkImg forState:UIControlStateNormal];
    }else
    {
        [self setImage:_unCheckImg forState:UIControlStateNormal];
    }
}

@end
