//
//  OMORemoteResultVC.m
//  OMO_iphone
//
//  Created by wy on 2018/10/25.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMORemoteResultVC.h"

@interface OMORemoteResultVC ()

@end

@implementation OMORemoteResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self omo_requestDataSouce];
}
- (void)omo_requestDataSouce{
    
    [[OMONetworkManager sharedData]postWithURLString:@"41012" parameters:@{@"remote_appoint_id":_remote_appoint_id} success:^(id responseObject) {
        
        if(responseObject){
            
            
        }
    } failure:^(NSError *error) {
        
        [MBProgress hideAllHUD];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
