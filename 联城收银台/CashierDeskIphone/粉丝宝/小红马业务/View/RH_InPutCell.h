//
//  RH_InPutCell.h
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_InPutFrame;

@protocol RH_InPutDelegate <NSObject>

- (void)RedCountFieldEndChange:(UITextField *)field;

- (void)RedCountFieldChange:(UITextField *)field;

@end

@interface RH_InPutCell : UITableViewCell

+ (instancetype)RH_InPutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_InPutFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t chooseCarBlock;

@property (nonatomic, copy) dispatch_block_t redCopiesBlock;

@property (nonatomic, copy) dispatch_block_t redProportionBlock;

//@property (nonatomic, copy) dispatch_block_t staffBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, strong) id<RH_InPutDelegate> delegate;

@end
