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
@interface CameraViewController : UIViewController {
    IBOutlet UIView *frameforCapture;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *cancelPicButton;
    IBOutlet UIButton *takePictureButton;
}

- (IBAction) takePhoto:(id)sender;
- (IBAction) cancelPhoto:(id)sender;
@end
