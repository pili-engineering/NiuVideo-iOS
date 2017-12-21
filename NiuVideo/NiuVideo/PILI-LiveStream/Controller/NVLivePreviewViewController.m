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
#import "NVLiveCoverView.h"
#import "NVLiveSettingSegmentViewController.h"

@interface NVLivePreviewViewController ()
<
PLMediaStreamingSessionDelegate
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
// 浮层，方便点击或者滑动全部隐藏
@property (nonatomic, strong) NVLiveCoverView               *coverView;

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

    [self checkCameraAccess];
    
    if (_cameraAccess && _microphoneAccess) {
        [self setupSession];
    }
    
    UIButton* testButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [testButton setTitle:@"start" forState:(UIControlStateNormal)];
    [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [testButton sizeToFit];
    [self.view addSubview:testButton];
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(@(testButton.bounds.size));
    }];
}

- (void)testButtonAction:(UIButton*)button {
//    [self startStream];
//    button.enabled = NO;
    [self.navigationController pushViewController:[[NVLiveSettingSegmentViewController alloc] init] animated:YES];
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
    
    _videoCaptureConfig = [PLVideoCaptureConfiguration defaultConfiguration];
    _videoStreamConfig  = [PLVideoStreamingConfiguration defaultConfiguration];
    _audioCaptureConfig = [PLAudioCaptureConfiguration defaultConfiguration];
    _audioStreamConfig  = [PLAudioStreamingConfiguration defaultConfiguration];
    
    _streamSession = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:_videoCaptureConfig
                                                              audioCaptureConfiguration:_audioCaptureConfig
                                                            videoStreamingConfiguration:_videoStreamConfig
                                                            audioStreamingConfiguration:_audioStreamConfig
                                                                                 stream:_stream];
    
    [self.view insertSubview:_streamSession.previewView atIndex:0];
    [_streamSession.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self requsetPushURL];
}

- (void)startStream {
    
    __weak typeof(self) wself = self;
    [_streamSession startStreamingWithPushURL:_streamURL feedback:^(PLStreamStartStateFeedback feedback) {
        NSLog(@"start stream %d", feedback);
        if (PLStreamStartStateSuccess == feedback) {
            // succeed
        } else {
            // failed
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
    _streamURL = [NSURL URLWithString:@"rtmp://pili-publish.pili2test.qbox.net/pili2test/anhaoxiong?e=1513321740&token=dSC2IIrmjNXONzPvVgXZo0mI0AI83835NIuXQ3iD:cs4YtYeoki6gOrm0OL7k99mr6HM="];
}

@end
