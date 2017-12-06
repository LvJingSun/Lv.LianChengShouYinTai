//
//  CategoryView.m
//  HuiHui
//
//  Created by mac on 14-7-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

@synthesize m_catogoryList;

@synthesize m_label;

@synthesize m_view;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_catogoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    
    return self;
}

- (id)init{
    
    self = [super init];
    
    if ( self ) {
        
        m_catogoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, WindowSize - 10, 26)];
        m_label.backgroundColor = [UIColor colorWithRed:243/255.0 green:248/255.0 blue:252/255.0 alpha:1.0];
        m_label.font = [UIFont systemFontOfSize:14.0f];
        m_label.textColor = [UIColor blackColor];

        
        
        m_view = [[UIView alloc]initWithFrame:CGRectMake(5, 30, WindowSize - 10, 110)];
        m_view.backgroundColor = [UIColor clearColor];
       
//        [self addSubview:m_label];
//        
        [self addSubview:m_view];
        
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setArray:(NSMutableArray *)array{
    
    if ( self.m_catogoryList.count != 0 ) {
        
        [self.m_catogoryList removeAllObjects];
    }
    
//    NSDictionary *all = [NSDictionary dictionaryWithObjectsAndKeys:@"全部", @"name", @"-1", @"code", nil];
//
//    [self.m_catogoryList addObject:all];
    
//    [ addObjectsFromArray:array];
    
    self.m_catogoryList = array;
    
    
    NSLog(@"arr = %@",array);
    
    self.backgroundColor = [UIColor clearColor];
    
//    m_label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//    
//    self.m_code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    
    int width = (WindowSize - 30)/2;
  
    // 循环添加按钮
    for (int i = 0; i < self.m_catogoryList.count; i ++) {
        
        NSDictionary *l_dic = [self.m_catogoryList objectAtIndex:i];
        
        NSString *status = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Status"]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];

        btn.frame = CGRectMake(i % 2 * (width + 10),  i / 2 * 60, width, 50);
        [btn setTitle:[l_dic objectForKey:@"SeatName"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"bd_14.png"] forState:UIControlStateNormal];
        
        // 未支付与已支付的状态值  1表示已支付 0 表示未支付
        if ( [status isEqualToString:@"1"] ) {
            
            btn.backgroundColor = [UIColor redColor];
            
        }else{
            
            btn.backgroundColor = [UIColor greenColor];
            
        }
        
        btn.tag = i;//[[l_dic objectForKey:@"CloudMenuOrderID"] intValue];
        [btn addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_view.backgroundColor = [UIColor clearColor];
        
        [m_view addSubview:btn];
        
        // 如果从诲诲上面点单的则显示预定的时间和昵称
        NSString *BookDateTime = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"BookDateTime"]];
        
        if ( BookDateTime.length != 0 ) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x,  btn.frame.origin.y + 35, width, 15)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:10.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [NSString stringWithFormat:@"预定时间 %@",BookDateTime];
            //[l_dic objectForKey:@"NickName"]
            [m_view addSubview:label];

        }
        
        
    }
    
    int count = [self.m_catogoryList count] % 2 == 0 ? [self.m_catogoryList count] / 2 : [self.m_catogoryList count] / 2 + 1;
    
    m_view.frame = CGRectMake(5, 30, WindowSize - 10, count * 60);
    
}

- (void)categoryClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *l_dic = [self.m_catogoryList objectAtIndex:btn.tag];

    if ( delegate && [delegate respondsToSelector:@selector(getCategoryClassId:)] ) {
        
        [delegate performSelector:@selector(getCategoryClassId:) withObject:l_dic];
    }
    
}



@end
