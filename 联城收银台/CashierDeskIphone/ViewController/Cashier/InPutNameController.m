//
//  InPutNameController.m
//  CashierDeskIphone
//
//  Created by mac on 2016/11/1.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "InPutNameController.h"
#import "InPutCell.h"
// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface InPutNameController ()<UITableViewDelegate,UITableViewDataSource> {

    NSString *productName;
    
}

@property (nonatomic, weak) UITextField *textfield;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UILabel *noLabel;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation InPutNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BJImage.png"]];
    
    [self setHeadView];
    
    [self setUITableView];
    
}

- (void)setHeadView {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    
    view.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:244/255. alpha:1.];
    
    [self.view addSubview:view];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH * 0.15, 30)];
    
    [cancleBtn setTitle:@"取消" forState:0];
    
    [cancleBtn setTitleColor:[UIColor colorWithRed:57/255. green:195/255. blue:58/255. alpha:1.] forState:0];
    
    [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancleBtn];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancleBtn.frame), 25, SCREEN_WIDTH * 0.7, 30)];
    
    self.textfield = textfield;
    
    textfield.backgroundColor = [UIColor whiteColor];
    
    textfield.layer.cornerRadius = 5;
    
    textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    textfield.layer.borderWidth = 0.5;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textfield.frame.size.width * 0.05, 30)];
    
    textfield.leftView = titleLab;
    
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:textfield];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textfield.frame), 25, SCREEN_WIDTH * 0.15, 30)];
    
    [sureBtn setTitle:@"确定" forState:0];
    
    [sureBtn setTitleColor:[UIColor colorWithRed:57/255. green:195/255. blue:58/255. alpha:1.] forState:0];
    
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sureBtn];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 64.5, SCREEN_WIDTH, 0.5)];
    
    line.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:line];
    
}

- (void)setUITableView {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    InPutCell *cell = [[InPutCell alloc] init];
    
    cell.titleLab.text = self.dataArray[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    InPutCell *cell = [[InPutCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InPutCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.textfield.text = cell.titleLab.text;
    
    [self sureClick];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSMutableArray *mutArray = [NSMutableArray array];
        
        [mutArray addObjectsFromArray:self.dataArray];
        
        [mutArray removeObjectAtIndex:indexPath.row];
        
        self.dataArray = mutArray;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:self.dataArray forKey:@"productNameArray"];
        
        [defaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)sureClick {

    productName = self.textfield.text;
    
    self.name(productName);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)returnName:(ReturnName)block {

    self.name = block;
    
}

- (void)dismiss {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self.textfield becomeFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *lastArray = [defaults valueForKey:@"productNameArray"];
    
    [defaults synchronize];
    
    self.dataArray = lastArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
