//
//  CameraViewController.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface CameraViewController : UIViewController

@property (nonatomic, strong)IBOutlet UIView *frameforCapture;
@property (nonatomic, strong)IBOutlet UIImageView *imageView;
@property (nonatomic, strong)IBOutlet UIButton *cancelPicButton;
@property (nonatomic, strong)IBOutlet UIButton *takePictureButton;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;


- (IBAction) takePhoto:(id)sender;
- (IBAction) cancelPhoto:(id)sender;
@end
