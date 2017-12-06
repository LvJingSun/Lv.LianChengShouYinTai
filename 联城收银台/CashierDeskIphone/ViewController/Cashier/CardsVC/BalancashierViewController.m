//
//  BalancashierViewController.m
//  CashierDeskIphone
//
//  Created by 冯海强 on 15-4-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//
#define RGBACKTAB  [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]

#import "BalancashierViewController.h"

#import "CashierTaoCanViewController.h"

@interface BalancashierViewController ()

@property (nonatomic,strong)NSMutableArray *MenuList;

@property (weak, nonatomic) IBOutlet UIButton *m_surepayBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_taocanBtn;


- (IBAction)tabcanBtnClicked:(id)sender;

@end

@implementation BalancashierViewController

@synthesize m_goodsId;

@synthesize m_flagDic;

@synthesize m_seatId;

@synthesize m_seatList;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    BCMOpened = NO;
    [self initDemoData];
    self.MenuList = [[NSMutableArray alloc]initWithCapacity:0];
    [mentiubtn addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    mentiubtn.layer.borderWidth = 1.0f;
    mentiubtn.layer.borderColor = RGBACKTAB.CGColor;
    mentiubtn.backgroundColor = [UIColor whiteColor];
    mentiubtn.titleLabel.textColor = RGBACKTAB;
    
    
    m_flagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    m_seatList = [[NSMutableArray alloc]initWithCapacity:0];
    
    sum = 0;
    
    // 版本判断
    if ( isIOS7 ) {
        
        [self.m_titleVIew setFrame:CGRectMake(0, 20, 320, 48)];
        
        if ( iPhone5 ) {
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height - 20 - 48)];
            
        }else{
            
            [self.m_tempView setFrame:CGRectMake(0, 68, 320, [[UIScreen mainScreen]bounds].size.height)];
            
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        label.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:label];
        
    }else{
        
        [self.m_titleVIew setFrame:CGRectMake(0, 0, 320, 48)];
        
        [self.m_tempView setFrame:CGRectMake(0, 48, 320, self.view.frame.size.height - 48)];
        
    }
    
    downView = [[BCloundMenuViewController alloc]initWithNibName:@"BCloundMenuViewController" bundle:nil];
    CGRect frame = self.m_tempView.frame;
    frame.size.height = 0;
    [downView.view setFrame:frame];
    [self.view addSubview:downView.view];

    
    self.m_confirmView.layer.masksToBounds = YES;
    self.m_confirmView.layer.cornerRadius = 8.0;
    
    self.m_photoView.layer.masksToBounds = YES;
    self.m_photoView.layer.cornerRadius = 30.0;
    
    moneytextfield.delegate = self;

    self.m_phonelabel.text = [self ittemDisposeIdcardNumber:[self.m_dic objectForKey:@"Account"]];
    self.m_namelabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RealName"]];
    
    // 默认显示的是收银
    [self.m_surepayBtn setTitle:@"确认收银" forState:UIControlStateNormal];
    
    [self.m_surepayBtn addTarget:self action:@selector(SurePay:) forControlEvents:UIControlEventTouchUpInside];
    
    mentiubtn.hidden = YES;
    
    // 按钮的圆角
    self.m_taocanBtn.layer.masksToBounds = YES;
    self.m_taocanBtn.layer.cornerRadius = 30.0;
    
    [self setphoto];
    
    
    self.m_seatId = @"";
    
    // 根据值来判断是否是点菜模式还是美容模式  隐藏美容行业下的套餐按钮========test
    NSString *isSeat = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSelectSeat"]];
    
    if ( [isSeat isEqualToString:@"1"] ) {
        
        self.m_taocanBtn.hidden = YES;
        
         mentiubtn.hidden = NO;
        
        // 座位列表请求数据
        [self seatRequestSubmit];
        
    }else{
        
        self.m_taocanBtn.hidden = NO;
        
        mentiubtn.hidden = YES;

    }
    
    if ([self.shouyin_Type isEqualToString:@"2"] || [self.shouyin_Type isEqualToString:@"3"]) {
        
        mentiubtn.hidden = YES;
        
    }
  
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [moneytextfield resignFirstResponder];
}

- (IBAction)backLastView:(id)sender {
    
    [self goBack];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hideNumberPadKeyboard:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //输入字符限制
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (filtered.length == 0) {
        //支持删除键
        return [string isEqualToString:@""];
    }
    if (textField.text.length == 0) {
        return ![string isEqualToString:@"."];
    }
    //第一位为0，只能输入.
    else if (textField.text.length == 1){
        if ([textField.text isEqualToString:@"0"]) {
            return [string isEqualToString:@"."];
        }
    }
    else{//只能输入一个.
        if ([textField.text rangeOfString:@"."].length) {
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            //两位小数
            NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
            if (ary.count == 2) {
                if ([ary[1] length] == 2) {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

- (NSString *)ittemDisposeIdcardNumber:(NSString *)idcardNumber {
    //星号字符串
    NSString *xinghaoStr = @"";
    //动态计算星号的个数
    for (int i  = 0; i < idcardNumber.length - 7; i++) {
        xinghaoStr = [xinghaoStr stringByAppendingString:@"*"];
    }
    //身份证号取前3后四中间以星号拼接
    idcardNumber = [NSString stringWithFormat:@"%@%@%@",[idcardNumber substringToIndex:3],xinghaoStr,[idcardNumber substringFromIndex:idcardNumber.length-4]];
    //返回处理好的身份证号
    return idcardNumber;
}

- (IBAction)SurePay:(id)sender
{
    if (moneytextfield.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"输入消费金额"];
        return;
    }
    
    [self initiaterequestSubmit];
    
}

- (void)setphoto{
    
    NSString *path = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PhotoBigUrl"]];
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
    
    if (reSizeImage != nil) {
        self.m_photoView.image = reSizeImage;
        return;
    }
        
    // 图片加载
    [self.m_photoView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]] placeholderImage:[UIImage imageNamed:@"moren.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        self.m_photoView.image = image;
        
        [self.imageCache addImage:image andUrl:path];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        self.m_photoView.image = [UIImage imageNamed:@"moren.png"];
    }];
    
}

//发起收银，会产生环信透传消息
- (void)initiaterequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"VipCardRecordId"]],@"vipCardRecordId",
                                [NSString stringWithFormat:@"%@",moneytextfield.text],@"balance",
                                @"收银",@"desc",
                                self.shouyin_Type,@"type",
                                nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中..."];
    
    [requstClient request:CHTTPRequestVIPCardPay parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];

        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];

            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView:) userInfo:nil repeats:NO];

            [self GOReturnblock];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];

}

- (void)returnText:(ReturniscleanBlock)block;
{ 
    self.returnBoolBlock = block;

}


- (void)GOReturnblock
{
    if (self.returnBoolBlock != nil) {
        self.returnBoolBlock(@"CardtextClean");
    }
}


- (IBAction)PushdownOpenBtn:(id)sender{
   
    [self.view endEditing:YES];
    
    if (BCMOpened) {
        
        [self.m_pushdownbtn setTitle:@"  菜单" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = downView.view.frame;
            frame.size.height = 0;
            [downView.view setFrame:frame];
            
        } completion:^(BOOL finished){
           
            BCMOpened = NO;
            
            // 根据字典的值转换成json的字符格式
            [self getDicToJson];
            
        }];
    }else{
        
        [self.m_pushdownbtn setTitle:@"  完成" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = downView.view.frame;
            frame.size.height = self.m_tempView.frame.size.height;
            [downView.view setFrame:frame];
            
            
        } completion:^(BOOL finished){
            BCMOpened = YES;
        }];
    }
}

- (void)getDicToJson{

    NSString *string = @"";
    
    int totalAmount = 0;
    
    sum = 0;
    
    for (int i = 0; i < downView.m_flagDic.count; i++) {
        
        NSMutableDictionary *dic = [downView.m_flagDic objectForKey:[NSNumber numberWithInt:i]];
        
        if ( dic.count != 0 ) {
                        
            for (int i = 0; i < [[dic objectForKey:@"TotalCount"] intValue]; i++) {
                
                NSMutableDictionary *l_dic = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)i]];
                
                if ( l_dic.count != 0 ) {
                    
                    NSString *price = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"price"]];
                    
                    NSString *amout = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"amount"]];
                    
                    NSString *menuId = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"menuId"]];

                    
                    
                    NSString *l_string = @"";
                    
                    self.m_flagDic = [l_dic mutableCopy];
                    
                    if ( ![amout isEqualToString:@"0"] ) {
                        
                        [self.m_flagDic removeObjectForKey:@"price"];
                        
                        float totalPrice = [amout intValue] * [price floatValue];
                        
                        sum = sum +totalPrice;
                        
                        
                        totalAmount = totalAmount + [amout intValue];
                        
                        
                        // 拼接成json字符
//                        l_string = [self dictionaryToJson:self.m_flagDic];
                        
                        l_string = [NSString stringWithFormat:@"{\"amount\":\"%@\",\"menuId\":\"%@\"},",amout,menuId];
                        
                        
                    }
                    
                    string = [string stringByAppendingString:l_string];
                    

                }
                
            }
            
        }
      
    }
    
    if ( totalAmount == 0 ) {
        // 表示没有选择任何菜单
        [self.m_surepayBtn setTitle:@"确认收银" forState:UIControlStateNormal];
        
        [self.m_surepayBtn removeTarget:self action:@selector(orderMenu) forControlEvents:UIControlEventTouchUpInside];
        [self.m_surepayBtn addTarget:self action:@selector(SurePay:) forControlEvents:UIControlEventTouchUpInside];
        
        mentiubtn.hidden = YES;
        
        // 对textField进行赋值
        moneytextfield.text = @"";
        
        
    }else{
        
        // 当选择了菜单后变成确认点单的操作及选择座位
        [self.m_surepayBtn setTitle:@"确认点单" forState:UIControlStateNormal];
        
        [self.m_surepayBtn removeTarget:self action:@selector(SurePay:) forControlEvents:UIControlEventTouchUpInside];

        [self.m_surepayBtn addTarget:self action:@selector(orderMenu) forControlEvents:UIControlEventTouchUpInside];
        
        // 对textField进行赋值
        moneytextfield.text = [NSString stringWithFormat:@"%.2f",sum];
        
        // 设置拼接的字符串
        string = [string substringWithRange:NSMakeRange(0, string.length - 1)];
        
        self.m_goodsId = [NSString stringWithFormat:@"\{\"goodList\":[%@]}",string];
        
    }
   
}

- (void)orderMenu{
    
    if ( moneytextfield.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入消费金额"];
        
        return;
    }
    
    // 根据值来判断是否是点菜模式还是美容模式  1表示点菜模式，即可选择座位 否则不可选择座位
    NSString *isSeat = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSelectSeat"]];
    
    if ( [isSeat isEqualToString:@"1"] ) {
        // 点菜模式
        if ( self.m_seatId.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择座位号"];
            
            return;
            
        }
        
        [self menuOrderRequest];

        
    }else{
    
        // 美容模式
        [self BeautyOrderRequest];
        
    }
    
    
    
}

// 美容模式下单请求数据
- (void)BeautyOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]],@"account",
                                self.m_goodsId,@"goods",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",parameters);
    
    [requstClient request:@"CloudMenuBuy.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            NSString *msg = [handlJson valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];

    
}


// 点菜模式下单请求数据
- (void)menuOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",
                                [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]],@"account",
                                self.m_goodsId,@"goods",
                                self.m_seatId,@"seatId",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"AddCloudMenuOrder.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            NSString *msg = [handlJson valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:@"MenuOrderListKey"];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(backLastView) userInfo:nil repeats:NO];

            
            
        }else
        {
            [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         [CommonUtil addValue:@"0" andKey:@"MenuOrderListKey"];

         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}

- (void)backLastView{
    
    [self goBack];
    
}


- (void)seatRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    // 刷新请求数据接口
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                memberId, @"cashierAccountID",
                                key,@"key",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [requstClient request:@"SeatList.ashx" parameters:parameters successed:^(JSONDecoder*json,id responseObject){
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json2222 = %@",handlJson);
            
            // 赋值
            self.m_seatList = [handlJson valueForKey:@"SeatList"];
            
            // 初始化座位
            [self initDemoData];
            
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
    } failured:^(NSError* error)
     {
         
         [SVProgressHUD showErrorWithStatus:error.description];
     }];
    
    
}



/*- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}*/


- (void)clickMenu{
    
    DownSheet *sheet = [[DownSheet alloc]initWithlist:menta height:0];
    sheet.delegate = self;
    [sheet showInView:nil];
    
}

- (void)initDemoData{
    
    menta = [[NSMutableArray alloc]initWithCapacity:0];
    
    if ( self.m_seatList.count != 0 ) {
        
        for (int i = 0; i < self.m_seatList.count; i++) {
            
            NSDictionary *dic = [self.m_seatList objectAtIndex:i];
            
            DownSheetModel *Model = [[DownSheetModel alloc]init];
            
            Model.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]];
            
            [menta addObject:Model];
            
        }
        
        
    }else{
        
        DownSheetModel *Model_1 = [[DownSheetModel alloc]init];
        Model_1.title = @"暂无座位";
        
        menta = @[Model_1];
        
    }
  
    
}

-(void)didSelectIndex:(NSInteger)index{
    
    if ( self.m_seatList.count != 0 ) {
        
        NSDictionary *dic = [self.m_seatList objectAtIndex:index];
        
        [mentiubtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatName"]] forState:UIControlStateNormal];
        
        self.m_seatId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SeatId"]];
    
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"暂无空座位"];
        
    }
 
}

- (IBAction)tabcanBtnClicked:(id)sender {
    
    // 进入用户套餐的页面
    CashierTaoCanViewController *VC = [[CashierTaoCanViewController alloc]initWithNibName:@"CashierTaoCanViewController" bundle:nil];
    VC.m_phoneString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
