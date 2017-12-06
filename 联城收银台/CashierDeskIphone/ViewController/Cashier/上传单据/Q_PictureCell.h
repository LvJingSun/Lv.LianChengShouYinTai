//
//  Q_PictureCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/2/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Q_PictureCell : UITableViewCell

//+ (instancetype)Q_PictureCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIButton *hetongBtn;

@property (nonatomic, weak) UIButton *fapiaoBtn;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UIButton *sureBtn;

@end
