//
//  NVLivePreviewViewController.m
//  NiuVideo
//
//  Created by hxiongan on 2017/12/15.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "NVLivePreviewViewController.h"
#import <PLStreamingKit.h>
#import <PLMediaStreamingKit.h>
#import <PLRTCStreamingKit.h>
#import <PLCommon.h>

#import "NVLiveSettingSegmentViewController.h"
#import "NVLiveCoverView.h"
#import "NVStartLiveView.h"
#import "NVLiveToolBoxView.h"

@interface NVLivePreviewViewController ()
<
PLMediaStreamingSessionDelegate,
NVLiveCoverViewDelegate,
NVStartLiveViewDelegate,
NVLiveToolBoxViewDelegate
>

// stream
@property (nonatomic, strong) PLMediaStreamingSession       *streamSession;
@property (nonatomic, strong) PLVideoCaptureConfiguration   *videoCaptureConfig;
@property (nonatomic, strong) PLVideoStreamingConfiguration *videoStreamConfig;
@property (nonatomic, strong) PLAudioCaptureConfiguration   *audioCaptureConfig;
@property (nonatomic, strong) PLAudioStreamingConfiguration *audioStreamConfig;
@property (nonatomic, strong) PLStream                      *stream;
@property (nonatomic, strong) NSURL                         *streamURL;

// UI
/// 浮层，方便点击或者滑动全部隐藏
@property (nonatomic, strong) NVLiveCoverView               *coverView;
@property (nonatomic, strong) NVStartLiveView               *startLiveView;
@property (nonatomic, strong) NVLiveToolBoxView             *toolBoxView;

@property (nonatomic)    BOOL cameraAccess;
@property (nonatomic)    BOOL microphoneAccess;

@end

@implementation NVLivePreviewViewController

- (void)dealloc {
    [self stopStream];
    [_streamSession destroy];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    [self hideView:self.coverView];
    [self.toolBoxView hide];
    
    [self requsetPushURL];
    
    [self checkCameraAccess];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupSession];
}

- (void)viewDidDisappear:(BOOL)animated {

    [self.streamSession.previewView removeFromSuperview];
    [self.streamSession destroy];
    self.streamSession = nil;
    
    [self hideView:self.coverView];
    [self showView:self.startLiveView];
    
    [super viewDidDisappear:animated];
}

- (void)setupUI {
    
    _coverView = [[NVLiveCoverView alloc] init];
    _coverView.delegate = self;
    
    _startLiveView = [[NVStartLiveView alloc] init];
    _startLiveView.delegate = self;
    
    _toolBoxView = [[NVLiveToolBoxView alloc] init];
    _toolBoxView.delegate = self;
    
    [self.view addSubview:_coverView];
    [self.view addSubview:_startLiveView];
    [self.view addSubview:_toolBoxView];
    
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_startLiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_toolBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)hideView:(UIView*)view {
    
    [UIView animateWithDuration:.3 animations:^{
        view.alpha = 0.0;
    } completion:^(BOOL finished) {
        view.hidden = YES;
    }];
}

- (void)showView:(UIView*)view {
    
    view.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - 检查并获取相机和microphone的访问权限

- (void)checkCameraAccess {
    
    PLAuthorizationStatus status = [PLMediaStreamingSession cameraAuthorizationStatus];
    if (PLAuthorizationStatusNotDetermined == status) {
        [self requestCameraAccess];
    } else if (PLAuthorizationStatusDenied == status) {
        //alert failed,
    } else {
        _cameraAccess = YES;
    }
    
    status = [PLMediaStreamingSession microphoneAuthorizationStatus];
    if (PLAuthorizationStatusNotDetermined == status) {
        [self requestMicrophoneAccess];
    } else if (PLAuthorizationStatusDenied == status) {
        //alert failed, go to iphone setting
    } else {
        _microphoneAccess = YES;
    }
}

- (void)requestCameraAccess {
    
    __weak typeof(self) wself = self;
    [PLMediaStreamingSession requestCameraAccessWithCompletionHandler:^(BOOL granted) {
        wself.cameraAccess = granted;
        if (!granted) {
            //alert failed
        } else {
            [wself setupSession];
        }
    }];
}

- (void)requestMicrophoneAccess {
    
    __weak typeof(self) wself = self;
    [PLMediaStreamingSession requestMicrophoneAccessWithCompletionHandler:^(BOOL granted) {
        wself.microphoneAccess = granted;
        if (!granted) {
            //alert failed
        } else {
            [wself setupSession];
        }
    }];
}

#pragma mark - 流控制模块

- (void)setupSession {
    
    if (!(_microphoneAccess && _cameraAccess)) return;
    if (_streamSession) return;
    
    if (nil == _videoStreamConfig) {
        _videoCaptureConfig = [PLVideoCaptureConfiguration defaultConfiguration];
        _videoStreamConfig  = [PLVideoStreamingConfiguration defaultConfiguration];
        _audioCaptureConfig = [PLAudioCaptureConfiguration defaultConfiguration];
        _audioStreamConfig  = [PLAudioStreamingConfiguration defaultConfiguration];
    }
    
    _streamSession = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:_videoCaptureConfig
                                                              audioCaptureConfiguration:_audioCaptureConfig
                                                            videoStreamingConfiguration:_videoStreamConfig
                                                            audioStreamingConfiguration:_audioStreamConfig
                                                                                 stream:_stream];
    
    [self.view insertSubview:_streamSession.previewView atIndex:0];
    [_streamSession.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)startStream {
    
    // show waiting .....
    
    __weak typeof(self) wself = self;
    [_streamSession startStreamingWithPushURL:_streamURL feedback:^(PLStreamStartStateFeedback feedback) {
        NSLog(@"start stream %lu", (unsigned long)feedback);
        // hide waiting .....
        
        if (PLStreamStartStateSuccess == feedback) {
            [wself hideView:wself.startLiveView];
            [wself showView:wself.coverView];
        } else {
            //alert failed
        }
    }];
}

- (void)stopStream {
    if ([_streamSession isStreamingRunning]) {
        [_streamSession stopStreaming];
    }
}

- (void)requsetPushURL {
    //temp
    _streamURL = [NSURL URLWithString:@""];
}


#pragma mark - NVLiveCoverViewDelegate

- (void)liveCoverViewCloseAction:(NVLiveCoverView *)liveCoverView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)liveCoverViewShareAction:(NVLiveCoverView *)liveCoverView {
    
}

- (void)liveCoverViewCommentAction:(NVLiveCoverView *)liveCoverView {
    [self.toolBoxView show];
}

- (void)liveCoverViewMessageAction:(NVLiveCoverView *)liveCoverView {
    
}

- (void)liveCoverViewSettingAction:(NVLiveCoverView *)liveCoverView {
    [self presentViewController:[[NVLiveSettingSegmentViewController alloc] init]];
}

#pragma mark - NVStartLiveViewDelegate

- (void)startLiveView:(NVStartLiveView *)liveView startLiveWithTitle:(NSString *)title {
    [self startStream];
}

- (void)startLiveViewCloseButtonClick:(NVStartLiveView *)liveView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
