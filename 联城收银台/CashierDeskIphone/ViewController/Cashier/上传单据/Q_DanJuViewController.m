//
//  Q_DanJuViewController.m
//  CashierDeskIphone
//
//  Created by mac on 2017/2/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Q_DanJuViewController.h"
#import "Q_DanJuCell.h"
#import "Q_PictureCell.h"

#import "SVProgressHUD.h"
#import "HttpClientRequest.h"
#import "AppHttpClient.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface Q_DanJuViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {

    NSInteger TAG;
    
    UIImage *heTongIMG;
    
    UIImage *faPiaoIMG;
    
    //存储图片的字典
    NSMutableDictionary *pictures;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UIButton *hetongBtn;

@property (nonatomic, weak) UIButton *fapiaoBtn;

@end

@implementation Q_DanJuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    heTongIMG = nil;
    
    faPiaoIMG = nil;
    
    self.title = @"上传";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithTableview];
    
}

- (void)initWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 8;
        
    }else {
    
        return 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        Q_DanJuCell *cell = [[Q_DanJuCell alloc] init];
        
        if (indexPath.row == 0) {
            
            cell.titleLab.text = @"账号：";
            
            cell.valueLab.text = self.phone;
            
        }else if (indexPath.row == 1) {
        
            cell.titleLab.text = @"用户姓名：";
            
            cell.valueLab.text = self.name;
            
        }else if (indexPath.row == 2) {
            
            cell.titleLab.text = @"商品名称：";
            
            cell.valueLab.text = self.productName;
            
        }else if (indexPath.row == 3) {
            
            cell.titleLab.text = @"交易金额：";
            
            cell.valueLab.text = self.tranCount;
            
        }else if (indexPath.row == 4) {
            
            cell.titleLab.text = @"全返金额：";
            
            cell.valueLab.text = self.fanCount;
            
        }else if (indexPath.row == 5) {
            
            cell.titleLab.text = @"金种子：";
            
            cell.valueLab.text = self.count;
            
        }else if (indexPath.row == 6) {
            
            cell.titleLab.text = @"返利周期：";
            
            cell.valueLab.text = self.cycleName;
            
        }else if (indexPath.row == 7) {
            
            cell.titleLab.text = @"促销员：";
            
            cell.valueLab.text = self.staffName;
            
        }
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        NSString *cellID = [NSString stringWithFormat:@"cellID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        
        Q_PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[Q_PictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        self.hetongBtn = cell.hetongBtn;
        
        cell.hetongBtn.tag = 1;
        
        [cell.hetongBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        
        self.fapiaoBtn = cell.fapiaoBtn;
        
        cell.fapiaoBtn.tag = 2;
        
        [cell.fapiaoBtn addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.sureBtn addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else {
    
        return nil;
        
    }
    
}

- (void)selectImage:(UIButton *)sender{
    
    TAG = sender.tag;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
        {
            [self PaiZhao];
        }
            break;
        case 1:
        {
            [self XiangCe];
        }
            break;
            
        default:
            break;
    }
    
}

//拍照选取图片
- (void)PaiZhao {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持拍照功能！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

//相册选取图片
- (void)XiangCe {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持相册功能！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }
    
}

//点击cancle实现的代理
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//拍照完成实现的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (TAG == 1) {
        
        [self.hetongBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
        heTongIMG = image;
        
    }else if (TAG == 2) {
        
        [self.fapiaoBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:0];
        
        faPiaoIMG = image;
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//确认赠送按钮点击
- (void)SureClick {

    if (heTongIMG == nil && faPiaoIMG == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择(合同/销售单/收据/发票)图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    }else {
    
        pictures = [[NSMutableDictionary alloc] init];
        
        if (heTongIMG != nil) {
            
            [pictures setValue:UIImageJPEGRepresentation(heTongIMG, 0.3) forKey:@"name1"];
            
        }
        
        if (faPiaoIMG != nil) {
            
            [pictures setValue:UIImageJPEGRepresentation(faPiaoIMG, 0.3) forKey:@"name2"];
            
        }
        
        [self pushData];
        
    }
    
}

//提交数据
- (void)pushData {
    
    HttpClientRequest* requstClient = [HttpClientRequest sharedInstance];
    NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.phone,@"phone",
                                self.CashierAccountID,@"CashierAccountID",
                                self.count,@"jinzhongzi",
                                self.cycle,@"cycle",
                                self.tranCount,@"TranAccount",
                                self.staff,@"yuangong",
                                self.productName,@"goodsname",
                                self.fanCount,@"allaccount",
                                @"2",@"status",
                                nil];
    
    [SVProgressHUD showWithStatus:@"赠送中..."];
    
    [requstClient multipartFormRequest:@"PaymentCheck_Jinzhongzi_1.ashx" parameter:parameters file:pictures successed:^(JSONDecoder *json, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [json objectWithData:data];
        
        BOOL success = [[handlJson objectForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
            [self saveProductName];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            
        }else
        {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[handlJson objectForKey:@"msg"]]];
            
        }
        
    } failured:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];

}

//保存商品名
- (void)saveProductName {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *lastArray = [defaults valueForKey:@"productNameArray"];
    
    NSMutableArray *productNameArray = [NSMutableArray array];
    
    [productNameArray addObjectsFromArray:lastArray];
    
    BOOL isContain = [lastArray containsObject:self.productName];
    
    if (!isContain) {
        
        [productNameArray addObject:self.productName];
        
    }
    
    [defaults setObject:productNameArray forKey:@"productNameArray"];
    
    [defaults synchronize];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        Q_DanJuCell *cell = [[Q_DanJuCell alloc] init];
        
        return cell.height;
        
    }else if (indexPath.section == 1) {
    
        Q_PictureCell *cell = [[Q_PictureCell alloc] init];
        
        return cell.height;
        
    }else {
        
        return 0;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
