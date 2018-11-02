//
//  OMOClearCacheVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/30.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOClearCacheVC.h"
/**  */
#import "OMOClearCacheCell.h"
/**  */
#import "OMOClearCacheAlertView.h"

@interface OMOClearCacheVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSouce;

@end

static NSString *OMOClearCacheCellID = @"OMOClearCacheCellID";

@implementation OMOClearCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatBar];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    [self.bar addTitltLabelWithText:@"清除缓存" Font:navTitleFont];
    
    [self omo_setDataSouce];
}
- (void)omo_setDataSouce{
    
    _dataSouce = [NSMutableArray array];
    //文件操作对象
    NSFileManager *manager = [NSFileManager defaultManager];
    //所查找文件夹的路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //目录迭代器
    NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:cachesPath];
    
    for (NSString *fileName in direnum) {
        
        if ([[fileName pathExtension] containsString:@"videos"]) {
            
            NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrDic = [manager attributesOfItemAtPath:filePath error:nil];
            NSNumber *fileSize = [attrDic objectForKey:NSFileSize];
            
            NSDictionary *dict = @{@"fileName":fileName,@"fileSize":[NSString stringWithFormat:@"%.1fM",fileSize.doubleValue / 1000]};
            
            [_dataSouce addObject:dict];
        }
    }
    
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{
    
    if(_tableView == nil){
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, IphoneY, SCREENW, SCREENH - IphoneY) style:UITableViewStylePlain];
        _tableView.backgroundColor = mainBackColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[OMOClearCacheCell class] forCellReuseIdentifier:OMOClearCacheCellID];
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:OMOClearCacheCellID];
    
    cell.dict = _dataSouce[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOClearCacheAlertView *clearCacheAlertView = [[OMOClearCacheAlertView alloc]init];
    
    __weak typeof(self) weakSelf = self;
    
    clearCacheAlertView.clearCacheBlock = ^{
        
        NSDictionary *dict = weakSelf.dataSouce[indexPath.row];
        
        //文件操作对象
        NSFileManager *manager = [NSFileManager defaultManager];
        //所查找文件夹的路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [cachesPath stringByAppendingPathComponent:dict[@"fileName"]];
        NSError *error;
        BOOL isClear = [manager removeItemAtPath:fileName error:&error];
        if(isClear){

            [weakSelf.dataSouce removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
        }else{

            [MBProgress showErrorMessage:@"清除缓存失败,请稍后再试"];
        }
    };
    [clearCacheAlertView show];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
