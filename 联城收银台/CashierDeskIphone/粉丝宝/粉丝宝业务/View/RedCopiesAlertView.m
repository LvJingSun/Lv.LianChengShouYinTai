//
//  RedCopiesAlertView.m
//  CashierDeskIphone
//
//  Created by mac on 2017/6/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RedCopiesAlertView.h"
#import "FSB_Header.h"

#import "Choose_CopiesModel.h"
#import "Choose_CopiesFrame.h"
#import "Choose_CopiesCell.h"

@interface RedCopiesAlertView () <UITableViewDelegate,UITableViewDataSource> {
    
    UIView *_contentView;
    
    CGFloat viewWidth;
    
    CGFloat viewHeight;
    
}

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation RedCopiesAlertView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
            
            [disbtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
            _contentView = [[UIView alloc] init];
            
            viewWidth = SCREENWIDTH * 0.6;
            
            viewHeight = SCREENHEIGHT * 0.5;
            
            _contentView.frame = CGRectMake((SCREENWIDTH - viewWidth) * 0.5, (SCREENHEIGHT - 64 - viewHeight) * 0.3, viewWidth, viewHeight);
            
            _contentView.layer.masksToBounds = YES;
            
            _contentView.layer.cornerRadius = 8;
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth * 0.1, 10, viewWidth * 0.8, 30)];
            
            lab.textColor = TitleColor;
            
            lab.font = TitleFont;
            
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.text = @"选择红包份数";
            
            [_contentView addSubview:lab];
            
            UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(viewWidth * 0.05, CGRectGetMaxY(lab.frame) + 5, viewWidth * 0.9, viewHeight - 10 - CGRectGetMaxY(lab.frame) - 5)];
            
            self.tableview = tableview;
            
            tableview.delegate = self;
            
            tableview.dataSource = self;
            
            tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            tableview.backgroundColor = [UIColor whiteColor];
            
            tableview.showsVerticalScrollIndicator = NO;
            
            [_contentView addSubview:tableview];
            
            [self addSubview:_contentView];
            
        }
        
    }
    
    return self;
    
}

-(void)setArray:(NSArray *)array {
    
    _array = array;
    
    [self.tableview reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Choose_CopiesCell *cell = [[Choose_CopiesCell alloc] init];
    
    Choose_CopiesFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Choose_CopiesFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Choose_CopiesFrame *frame = self.array[indexPath.row];
    
    self.choosecopies(frame.copiesmodel);
    
    [self disMissView];
    
}

- (void)returnStaff:(ChooseCopiesBlock)block {
    
    self.choosecopies = block;
    
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake((SCREENWIDTH - viewWidth) * 0.5,SCREENHEIGHT + (SCREENHEIGHT - 64 - viewHeight) * 0.3, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake((SCREENWIDTH - viewWidth) * 0.5, (SCREENHEIGHT - 64 - viewHeight) * 0.3, viewWidth, viewHeight)];
        
    } completion:nil];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake((SCREENWIDTH - viewWidth) * 0.5, (SCREENHEIGHT - 64 - viewHeight) * 0.3, viewWidth, viewHeight)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
         self.alpha = 0.0;
         
         [_contentView setFrame:CGRectMake((SCREENWIDTH - viewWidth) * 0.5,SCREENHEIGHT + (SCREENHEIGHT - 64 - viewHeight) * 0.3, viewWidth, viewHeight)];
                         
    } completion:^(BOOL finished){
                         
         [self removeFromSuperview];
         
         [_contentView removeFromSuperview];
        
    }];
    
}


@end
