//
//  OMOFeedbackVC.m
//  OMO_iphone
//
//  Created by wy on 2018/9/18.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOFeedbackVC.h"
#import "OMOFeedBackModel.h"
#import "OMOFeedbackCell.h"
#import "OMOFeedbackFootView.h"
#import "OMOCustomTextView.h"

@interface OMOFeedbackVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)OMOCustomTextView *textView;
@property (nonatomic, strong)UIButton *submitBtn;
@property (nonatomic, strong)NSArray <OMOFeedBackModel *> *dataSouce;
@property (nonatomic, strong)NSMutableArray *selectArr;

@end

static NSString *OMOFeedbackCellID = @"OMOFeedbackCellID";
static NSString *OMOFeedbackFootViewID = @"OMOFeedbackFootViewID";

@implementation OMOFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectArr = [NSMutableArray array];
    [self creatBar];
    [self.bar addTitltLabelWithText:@"意见反馈" Font:navTitleFont];
    [self.bar addLeftButtonWithImage:[UIImage imageNamed:@"App_Back"]];
    
    [self md_requestClientData];
}
#pragma mark ------- 请求列表数据 -----------
- (void)md_requestClientData{
    
    OMOFeedBackModel *model1 = [[OMOFeedBackModel alloc]init];
    model1.value = @"软件闪退";
    model1.isSelect = NO;
    
    OMOFeedBackModel *model2 = [[OMOFeedBackModel alloc]init];
    model2.value = @"软件崩溃";
    model2.isSelect = NO;
    
    OMOFeedBackModel *model3 = [[OMOFeedBackModel alloc]init];
    model3.value = @"页面空白";
    model3.isSelect = NO;
    
    OMOFeedBackModel *model4 = [[OMOFeedBackModel alloc]init];
    model4.value = @"功能无法操作";
    model4.isSelect = NO;
    
    OMOFeedBackModel *model5 = [[OMOFeedBackModel alloc]init];
    model5.value = @"评估不准确";
    model5.isSelect = NO;
    
    OMOFeedBackModel *model6 = [[OMOFeedBackModel alloc]init];
    model6.value = @"流程复杂";
    model6.isSelect = NO;
    
    _dataSouce = @[model1,model2,model3,model4,model5,model6];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.submitBtn];
}
- (OMOCustomTextView *)textView{
    
    if(_textView == nil){
        
        _textView = [[OMOCustomTextView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY + lwb_margin * 6 + 40 * 2, SCREENW - lwb_margin * 4, IFFitFloat6(200))];
        _textView.placehText = @"请输入您的建议和意见";
        _textView.textLength = 100;
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = lwb_margin;
        _textView.layer.borderWidth = 1.f;
        _textView.layer.borderColor = DetailColor.CGColor;
    }
    return _textView;
}
- (UIButton *)submitBtn{
    
    if(_submitBtn == nil){
        
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.lwb_y = SCREENH - 100;
        _submitBtn.lwb_size = CGSizeMake(SCREENW - 100, 50);
        _submitBtn.lwb_x = 50;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 25.f;
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = backColor;
        _submitBtn.titleLabel.font = bigFont;
        [_submitBtn addTarget:self action:@selector(md_submitBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (UICollectionView *)collectionView{
    
    if(_collectionView == nil){
        
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(lwb_margin * 2, IphoneY, SCREENW - lwb_margin * 4, SCREENH - IphoneY - 100) collectionViewLayout:collectionLayout];
        
        _collectionView.backgroundColor = WHITECOLORA(1);
        _collectionView.scrollEnabled = NO;
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        // 允许多选
        _collectionView.allowsMultipleSelection = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;// 默认为YES。如果该属性为YES，视图滚动时可以越过边界，越过边界后会被弹回。
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.alwaysBounceHorizontal = YES;
        
        [_collectionView registerClass:[OMOFeedbackCell class] forCellWithReuseIdentifier:OMOFeedbackCellID];
        // 
//        [_collectionView registerClass:[OMOFeedbackFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:OMOFeedbackFootViewID];
    }
    return _collectionView;
}

// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
// 行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSouce.count;
}
// cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOFeedbackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OMOFeedbackCellID forIndexPath:indexPath];
    
    cell.feedBackModel = _dataSouce[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OMOFeedBackModel *feedBackModel = _dataSouce[indexPath.row];
    BOOL isSelect = feedBackModel.isSelect;
    if(!isSelect){
        
        [_selectArr addObject:@([_dataSouce indexOfObject:feedBackModel] + 1)];
    }else{
        
        [_selectArr removeObject:@([_dataSouce indexOfObject:feedBackModel] + 1)];
    }
    
    feedBackModel.isSelect = !isSelect;
    
    [collectionView reloadData];
}
// iteam大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((collectionView.lwb_width - lwb_margin * 2) / 3, 40);
}

// 分区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake( lwb_margin * 2, 0, lwb_margin * 2, 0);
}

// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin * 2;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return lwb_margin;
}
#pragma mark --------- 提交反馈 ---------
- (void)md_submitBtnDidClick{
    
    if(_selectArr.count == 0 && _textView.text.length <= 0){
        
        [MBProgress showInfomationWithMessage:@"反馈信息不能为空" duration:lwb_duration];
        return;
    }
    
    NSMutableDictionary *parmars = [NSMutableDictionary dictionary];
    parmars[@"content"] = checkNull(_textView.text);
    NSString *type = [_selectArr componentsJoinedByString:@","];
    parmars[@"type"] = checkNull(type);
    
    [[OMONetworkManager sharedData] postWithURLString:@"10005" parameters:parmars success:^(id responseObject) {
        
        if(responseObject){
            
            [MBProgress showInfomationWithMessage:@"我们已收到您的反馈,谢谢您提的宝贵意见" duration:lwb_duration];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
