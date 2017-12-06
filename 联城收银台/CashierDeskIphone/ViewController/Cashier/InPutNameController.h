//
//  InPutNameController.h
//  CashierDeskIphone
//
//  Created by mac on 2016/11/1.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnName)(NSString *name);

@interface InPutNameController : UIViewController

@property (nonatomic, copy) ReturnName name;

- (void)returnName:(ReturnName)block;

@end
