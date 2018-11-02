//
//  OMOTrainingDetailHeadView.m
//  OMO_iphone
//
//  Created by wy on 2018/10/26.
//  Copyright © 2018年 刘卫兵. All rights reserved.
//

#import "OMOTrainingDetailHeadView.h"
/**  */
#import "TBPlayer.h"

@interface OMOTrainingDetailHeadView ()

/**  */
@property (nonatomic, strong)TBPlayer *player;

@end

@implementation OMOTrainingDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = WHITECOLORA(1);
        
        _player = [TBPlayer sharedInstance];
        
        //    OMOTrainResourceModel *resouceModel = [_videoSouce objectAtIndex:_index];
        //    NSString *sss = @"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4";
        //    NSString *url = resouceModel.url;
    }
    return self;
}
- (void)setUrl:(NSString *)url{
    
    _url = url;
    
    [_player playWithUrl:[NSURL URLWithString:@"http://img00.sun-hc.com/file/resource/20186/1529633366531.mp4"] showView:self];
}
@end
