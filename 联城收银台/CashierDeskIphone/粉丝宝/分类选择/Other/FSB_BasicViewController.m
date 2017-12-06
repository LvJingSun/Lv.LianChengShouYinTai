//
//  FSB_BasicViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_BasicViewController.h"
#import "FSB_Header.h"

@interface FSB_BasicViewController ()

@end

@implementation FSB_BasicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = BGColor;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = NAVTextColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:NAVFont,NSForegroundColorAttributeName:NAVTextColor}];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    self.navigationController.navigationBarHidden = NO;
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 40, 40)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setTitle:title forState:UIControlStateNormal];
    
    [addButton setTitleColor:NAVTextColor forState:0];
    
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

-(void)viewWillDisappear:(BOOL)animated {

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
