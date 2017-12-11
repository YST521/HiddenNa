//
//  MyPageViewController.m
//  WiseAPP
//
//  Created by app on 16/10/9.
//  Copyright © 2016年 YST. All rights reserved.
//



#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UserCellIdetifeir @"UserCell"

#import "MyPageViewController.h"
#import "ViewController.h"
#import "NaView.h"
#import "UserCell.h"

@interface MyPageViewController ()<NaViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_headerImg;
    UILabel *_nameLabel;
    NSMutableArray *_dataArray;
    
}
@property(nonatomic,strong)UIImageView *backgroundImgV;
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,strong)NaView *NavView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MyPageViewController
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self backImageView];
    
   
    
    [self loadData];
    
//    [self layoutTableView];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.showsVerticalScrollIndicator=NO;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    self.NavView=[[NaView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    self.NavView.title = @"我的";
    self.NavView.color = [UIColor redColor];
    self.NavView.left_bt_Image = @"left_";
    self.NavView.right_bt_Image = @"Setting";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
    
    
    //在iOS8中你可以这样判断
    NSString *str = @"hello world";
    if ([str containsString:@"world"]) {
        NSLog(@"str 包含 world");
    } else {
        NSLog(@"str 不存在 world");
    }
    
}


-(void)loadData{
    
    _dataArray =[[NSMutableArray alloc]init];
    
    for (int i = 0; i < 20; i++) {
        
        NSString * string=[NSString stringWithFormat:@"第%d行",i];
        
        [_dataArray addObject:string];
        
    }
    
}

#pragma mark ---- UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
   // cell.img_name = @"cell";
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    //170 上拉距离 显示title
    if (scrollView.contentOffset.y<=170) {
        self.NavView.headBackView.alpha = scrollView.contentOffset.y/170;

        self.NavView.color = [UIColor whiteColor];

       // [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }else{
        self.NavView.headBackView.alpha = 1;

        self.NavView.color = kColor(87, 173, 104, 1);
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
