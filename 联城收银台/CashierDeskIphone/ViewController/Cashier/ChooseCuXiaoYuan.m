//
//  ChooseCuXiaoYuan.m
//  CashierDeskIphone
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "ChooseCuXiaoYuan.h"
#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ChooseCuXiaoYuan ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ChooseCuXiaoYuan

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
        
        lab.text = @"请选择促销员";
        
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
                                memberId,@"cashierAccountID",
                                nil];
    
    [requstClient request:@"MctYuanGongList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *tempArr = handlJson[@"ybtrList"];
            
            self.array = tempArr;
            
            [self.tableview reloadData];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
         
     }];
    
}

#pragma mark 键盘出现
- (void)keyboardWillShow:(NSNotification *)note {
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
}
#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)note {
    
    self.tableview.contentInset = UIEdgeInsetsZero;
    
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
    
    NSDictionary *dic = self.array[indexPath.row];
    
    cell.textLabel.text = dic[@"RealName"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = self.array[indexPath.row];
    
    self.cuxiaoyuan(dic[@"RealName"],dic[@"CashierAccountID"]);
    
    [self removeFromSuperview];
    
}

- (void)ReturnCuXiao:(ReturnCuXiao)block {
    
    self.cuxiaoyuan = block;
    
}

- (void)dismissView {
    
    if (self) {
        
        [self removeFromSuperview];
        
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
