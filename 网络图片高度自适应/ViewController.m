//
//  ViewController.m
//  网络图片高度自适应
//
//  Created by 闫继祥 on 2019/8/8.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"

static NSString *const cellId = @"CustomTableViewCell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图片高度自适应";
    [self createTableView];
}
-(NSArray *)dataArray{
    if(_dataArray==nil)
    {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        _dataArray = json[@"data"];
        
    }
    return _dataArray;
}
- (void)createTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:self.tableView];
}
#pragma mark-tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = self.dataArray[indexPath.row];
    /**
     *  参数1:图片URL
     *  参数2:imageView 宽度
     *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
     */
    return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:url] layoutWidth:[UIScreen mainScreen].bounds.size.width estimateHeight:200];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = NO;
    NSString *url = self.dataArray[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"zhanweitu"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        /** 缓存image size */
        [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            /** reload  */
            if(result)  [tableView  xh_reloadDataForURL:imageURL];
        }];
    }];
    
    return cell;
}



@end
