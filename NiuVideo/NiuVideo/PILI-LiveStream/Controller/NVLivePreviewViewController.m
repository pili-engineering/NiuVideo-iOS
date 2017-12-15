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

@interface NVLivePreviewViewController ()

@property (nonatomic, strong) PLMediaStreamingSession       *streamSession;
@property (nonatomic, strong) PLVideoCaptureConfiguration   *videoCaptureConfig;
@property (nonatomic, strong) PLVideoStreamingConfiguration *videoStreamConfig;
@property (nonatomic, strong) PLAudioCaptureConfiguration   *audioCaptureConfig;
@property (nonatomic, strong) PLAudioStreamingConfiguration *audioStreamConfig;

@end

@implementation NVLivePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCaptureConfig = [PLVideoCaptureConfiguration defaultConfiguration];
    self.videoStreamConfig  = [PLVideoStreamingConfiguration defaultConfiguration];
    self.audioCaptureConfig = [PLAudioCaptureConfiguration defaultConfiguration];
    self.audioStreamConfig  = [PLAudioStreamingConfiguration defaultConfiguration];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setupSessionc {
    
}

@end
