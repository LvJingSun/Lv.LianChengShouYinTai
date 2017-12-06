//
//  ServiceCell.h
//  BusinessCenter
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell

+ (instancetype)ServiceCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *serviceImageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, assign) CGFloat height;

@end
