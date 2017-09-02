//
//  AddVideoScreen.h
//  YzChildren
//
//  Created by Hitesh Thummar on 09/06/15.
//  Copyright (c) 2015 Artoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamCaptureManager.h"
#import "AVCamRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@protocol AVCamRecorderDelegate;


@interface AddVideoScreen : UIView <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)onExit:(UIButton *)sender;


+(AddVideoScreen *)shareinstance;
+(AddVideoScreen *)CurrentInstance;
-(void)SetStopTimer;
@property (nonatomic,strong) AVCamCaptureManager *captureManager;
@property (nonatomic,strong) IBOutlet UIView *videoPreviewView;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

- (IBAction)startRecording:(UIButton *)sender;
- (IBAction)stopRecording:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *startbtn;
@property (strong, nonatomic) IBOutlet UIButton *stopbtn;


@property (strong, nonatomic) IBOutlet UILabel *minlabel;
@property (strong, nonatomic) IBOutlet UIImageView *backImg_min;

- (IBAction)ToggleCamera:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *togglebtn;

- (IBAction)flashLight_on_off:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *galleryview;



@end
