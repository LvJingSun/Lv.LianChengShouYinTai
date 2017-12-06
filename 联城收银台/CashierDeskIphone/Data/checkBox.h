//
//  checkBox.h
//  CashierDeskIphone
//
//  Created by mac on 13-9-7.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkBox : UIButton
{
    BOOL _isCheck;
    UIImage* _checkImg;
    UIImage* _unCheckImg;
}
@property(nonatomic,strong)UIImage* checkImg;
@property(nonatomic,strong)UIImage* unCheckImg;
@property(nonatomic,assign)BOOL isCheck;
-(void)initCheckImg:(UIImage*)checkImg UnCheckImg:(UIImage*)unCheckImg wihtCheckStatus:(BOOL)check;
-(void)setCheckBox:(BOOL)checkStatus;
@end
