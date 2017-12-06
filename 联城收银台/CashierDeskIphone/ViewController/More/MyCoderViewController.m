//
//  MyCoderViewController.m
//  CashierDeskIphone
//
//  Created by mac on 13-10-29.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MyCoderViewController.h"

#import "QRCodeGenerator.h"

@interface MyCoderViewController ()


@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

- (IBAction)goback:(id)sender;

@end

@implementation MyCoderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;

    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleView setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
             [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleView setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
    }

    // 生成二维码图片
    UIImage *codeImage = [QRCodeGenerator qrImageForString:[CommonUtil getValueByKey:ACCOUNT] imageSize:self.m_imageView.frame.size.width];
    [self.m_imageView setImage:codeImage];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {

    [self goBack];

}

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tempView:nil];
    [self setM_imageView:nil];
    [super viewDidUnload];
}
@end
