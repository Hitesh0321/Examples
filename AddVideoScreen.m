//
//  AddVideoScreen.m
//  YzChildren
//
//  Created by Hitesh Thummar on 09/06/15.
//  Copyright (c) 2015 Artoon. All rights reserved.
//

#import "AddVideoScreen.h"
#import "AVCamRecorder.h"
#import "AVCamCaptureManager.h"
#import "Constant.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AppDelegate.h"

static AddVideoScreen *screen;
NSTimer *TimerTime;
@implementation AddVideoScreen 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(AddVideoScreen *)shareinstance
{
    
    if (!screen) {
        screen=[[[NSBundle mainBundle]loadNibNamed:NIB_AddVIDEOSCREEN owner:self options:nil]objectAtIndex:0];
    }
    return  screen;
    
}

+(AddVideoScreen *)CurrentInstance
{
    return  screen;
}
int sec,min;
-(void)awakeFromNib
{
    
    
    if (TagCameraOrGallery==1) {
        
    if (IS_IPHONE_4_OR_LESS) {
        
        _startbtn.frame=CGRectMake(47,399, 45, 45);
        _stopbtn.frame=CGRectMake(233,399,45,45);
        _backImg_min.frame=CGRectMake(97,399,131,45);
        _minlabel.frame=CGRectMake(127, 407, 70,30);
        
        
    }
    
      _stopbtn.enabled=false;
    if ([self captureManager] == nil) {
        AVCamCaptureManager *manager = [[AVCamCaptureManager alloc] init];
        [self setCaptureManager:manager];
        
        [[self captureManager] setDelegate:self];
        
        if ([[self captureManager] setupSession]) {
            // Create video preview layer and add it to the UI
            AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
            UIView *view = [self videoPreviewView];
            CALayer *viewLayer = [view layer];
            [viewLayer setMasksToBounds:YES];
           
            
            CGRect bounds = [view bounds];
            [newCaptureVideoPreviewLayer setFrame:bounds];
            
            [newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            
            [viewLayer insertSublayer:newCaptureVideoPreviewLayer below:[viewLayer sublayers][0]];
            
            [self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
            
            // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[[self captureManager] session] startRunning];
            });
            
            
        }		
    }
    
    [self SetEnableToAll:[self.videoPreviewView subviews]];
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (device.torchMode == AVCaptureTorchModeOff)
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                NSLog(@"on");
            }
            else
            {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                NSLog(@"off");
            }
            [device unlockForConfiguration];
        }
    }

    }
    if (TagCameraOrGallery==2) {
        
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate=self;

        imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgPicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeVideo, (NSString *)kUTTypeMovie, nil];
    imgPicker.allowsEditing = NO;
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:imgPicker animated:YES completion:nil];
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
   [picker dismissViewControllerAnimated:YES completion:^{
       NSLog(@"%@",info);
       NSString *oldfile=[info objectForKey:@"UIImagePickerControllerMediaURL"];
      // NSURL *oldfile= [NSURL URLWithString:[info objectForKey:@"UIImagePickerControllerMediaURL"]];
       
      
      
       if (TagForVideo==101) {
           [self renameFile:oldfile newFile:Video1];
       }
       if (TagForVideo==102) {
           [self renameFile:oldfile newFile:video2];
       }
       
       if (TagForVideo==103) {
           [self renameFile:oldfile newFile:video3];
           [Defaults setBool:YES forKey:@"Vid3"];
       }
       if (TagForVideo==104) {
           [self renameFile:oldfile newFile:video4];
       }
       if (TagForVideo==105) {
           [self renameFile:oldfile newFile:video5];
       }
       if (TagForVideo==106) {
           [self renameFile:oldfile newFile:video6];
       }
    
   }];
    
    [self removeFromSuperview];
   
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self removeFromSuperview];
}
-(NSString *)renameFile:(NSString *)oldstr newFile:(NSString *)newStr
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * oldPath =oldstr;
    NSString * newPath =[[NSString alloc]init];
   
    newPath=[documentsDirectory stringByAppendingPathComponent:newStr];
    
    
    NSError *error;
    
    //remove file
    // Attempt to delete the file at filePath2
    
    if ([fileManager isDeletableFileAtPath:newPath])
    {
        if ([fileManager removeItemAtPath:newPath error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    }
    if ([fileManager fileExistsAtPath:newPath])
    {
            [fileManager moveItemAtPath:oldPath toPath:newPath error:&error];
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfFile:oldstr];
        [fileManager createFileAtPath:newPath contents:data attributes:nil];
    }
    
    
    //move file
    
    
   
    
        if (TagForVideo==101) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio1] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        if (TagForVideo==102) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio2] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        
        if (TagForVideo==103) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio3] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        
        if (TagForVideo==104) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio4] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        if (TagForVideo==105) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio5] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        if (TagForVideo==106) {
            if ([fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:audio6] error:&error] != YES)
                NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            
        }
        
        
    
    NSLog(@"%@",error);
    return newPath;
    
}


-(void)SetEnableToAll :(NSArray*)allSubviews
{
    for(UIView * view in allSubviews)
    {
        if([view isMemberOfClass:[UIButton class]])
        {
            [view setExclusiveTouch:YES];
        }
    }
    
}

-(void)SetStopTimer
{
    [TimerTime invalidate];
    TimerTime=nil;
    _startbtn.enabled=true;
    _stopbtn.enabled=true;
}



- (IBAction)onExit:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.videoPreviewView.frame =CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    [TimerTime invalidate];
    TimerTime=nil;


}

- (IBAction)startRecording:(UIButton *)sender {
    
    _stopbtn.enabled=true;
    _startbtn.enabled=false;
    _togglebtn.hidden=true;
    sec=min=0;
    
    [[self captureManager] startRecording];
     TimerTime=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];

}

- (IBAction)stopRecording:(UIButton *)sender {
    
     [[self captureManager] stopRecording];
    _startbtn.enabled=true;
    _stopbtn.enabled=false;
    [TimerTime invalidate];
    TimerTime=nil;
        _togglebtn.hidden=false;
    
    
}
-(void)updateLabel
{
    if (sec/59 == 1) {
        
        sec=0;
        min++;
    }
    else
    {
        sec++;
        if (sec==8) {
            [TimerTime invalidate];
            TimerTime=nil;
            [self stopRecording:0];
            return;
        }
        
    }
    NSLog(@"%d:%d",min,sec);
    _minlabel.text=[NSString stringWithFormat:@"%.2d:%.2d",min,sec];

    
}


- (void) captureManager:(AVCamCaptureManager *)captureManager didFailWithError:(NSError *)error{}
- (void) captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager{NSLog(@"start");}
- (void) captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager{}
- (void) captureManagerStillImageCaptured:(AVCamCaptureManager *)captureManager{}
- (void) captureManagerDeviceConfigurationChanged:(AVCamCaptureManager *)captureManager{}
- (IBAction)ToggleCamera:(UIButton *)sender {
    
    // Toggle between cameras when there is more than one
    [[self captureManager] toggleCamera];
    
    
    
    // Do an initial focus
    [[self captureManager] continuousFocusAtPoint:CGPointMake(.5f, .5f)];
    
    
    _startbtn.enabled=true;
    _stopbtn.enabled=false;
    _minlabel.text=[NSString stringWithFormat:@"00:00"];
    [TimerTime invalidate];
    TimerTime=nil;
    
}
- (IBAction)flashLight_on_off:(id)sender {
    
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (device.torchMode == AVCaptureTorchModeOff)
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                NSLog(@"on");
            }
            else
            {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                NSLog(@"off");
            }
            [device unlockForConfiguration];
        }
    }

    
}
@end
