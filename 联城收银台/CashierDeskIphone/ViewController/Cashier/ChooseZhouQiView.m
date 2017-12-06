//
//  ChooseZhouQiView.m
//  CashierDeskIphone
//
//  Created by mac on 16/9/2.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "ChooseZhouQiView.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"
#import "N_CycleType.h"
//屏幕宽度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ChooseZhouQiView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ChooseZhouQiView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.8];
        
        UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:dismissBtn];
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(50, 150, SCREENWIDTH - 100, SCREENHEIGHT - 300)];
        
        tableview.backgroundColor = [UIColor whiteColor];
        
        tableview.layer.cornerRadius = 5;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        self.tableview = tableview;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 100, 50)];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREENWIDTH - 100, 30)];
        
        lab.text = @"请选择返利周期";
        
        lab.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:lab];
        
        tableview.tableHeaderView = view;
        
        [self addSubview:tableview];
        
        [self requestData];
        
    }
    
    return self;
    
}

- (void)requestData{
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    
    NSString *memberId = [userDefau objectForKey:@"memberId"];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId,@"CashierAccountID",
                                nil];

    [requstClient request:@"NewCycletype.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = handlJson[@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in tempArr) {
                
                N_CycleType *type = [[N_CycleType alloc] initWithDict:dd];
                
                [mut addObject:type];
                
            }
            
            self.array = mut;
            
            [self.tableview reloadData];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    N_CycleType *type = self.array[indexPath.row];
        
    cell.textLabel.text = [NSString stringWithFormat:@"%@年",type.length];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    N_CycleType *type = self.array[indexPath.row];

    self.zhouqi(type);
    
    [self removeFromSuperview];
    
}

- (void)ReturnZhouQi:(ReturnZhouQi)block {

    self.zhouqi = block;
    
}

- (void)dismissView {

    if (self) {
        
        [self removeFromSuperview];
        
    }
    
}

@end
