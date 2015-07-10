//
//  CameraViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "CameraViewController.h"
#import "TableListViewController.h"
#import "Photo.h"
#import "Photographer.h"
#import "AppDelegate.h"
#import "CoreDataHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "SettingsViewController.h"

@interface CameraViewController ()
@end

@implementation CameraViewController

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;
CALayer *rootLayer;
NSCache *cache;
BOOL *pictureTaken;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    rootLayer = [[self view] layer];
    [self updateUI];
}

- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"SwipeToSettings" sender:self];
}

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"SwipeToList" sender:self];
}

- (void)updateUI
{
    pictureTaken = false;
    session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput   deviceInputWithDevice:inputDevice error:&error];
    if([session canAddInput:deviceInput]){
        [session addInput:deviceInput];
    }
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [rootLayer setMasksToBounds:YES];
    
    CGRect frame = self.frameforCapture.frame;
    [self.previewLayer setFrame:frame];
    [rootLayer insertSublayer:self.previewLayer above:0];
    
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    [session addOutput:StillImageOutput];
    [session startRunning];
    [self.cancelPicButton setHidden:TRUE];
    [self.takePictureButton setHidden:FALSE];
    //bring to front
    [rootLayer insertSublayer:self.takePictureButton.layer above:0];
}


-(IBAction)takePhoto:(id)sender
{
    self.previewLayer = nil;
    AVCaptureConnection *videoConnection = nil;
    for(AVCaptureConnection *connection in StillImageOutput.connections) {
        for(AVCaptureInputPort *port in [connection inputPorts]) {
            if([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
    }
    __block NSString *url = [[NSString alloc]init];

    [StillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer != NULL)
        {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
             {
                 url = [assetURL absoluteString];
                 NSLog(@"IMAGE SAVED TO PHOTO ALBUM %@", url);
                 [self savePhotoModel:url];

                 [library assetForURL:assetURL resultBlock:^(ALAsset *asset )
                  {
                      NSLog(@"we have our ALAsset!");
                  }
                         failureBlock:^(NSError *error )
                  {
                      NSLog(@"Error loading asset");
                  }];
             }];
            self.imageView.image = image;
            [self.previewLayer removeFromSuperlayer];
            NSLog(@"Outside block =  %@", url);
        }
    }];
    pictureTaken = TRUE;
    [self.cancelPicButton setHidden:FALSE];
    [self.takePictureButton setHidden:TRUE];

}

-(void) savePhotoModel:(NSString *)url
{
    //get instance of app delegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if ([appDelegate managedObjectContext] == nil)
    {
        context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext: %@",  context);
    }
    
    long timestamp = CFAbsoluteTimeGetCurrent();
    NSString *timestampString = [NSString stringWithFormat:@"%ld", timestamp];
    NSDate *date = [[NSDate alloc] init];
    date = [NSDate date];
    
    NSManagedObject *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    NSManagedObject *photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
    NSString *username =[cache objectForKey:@"currentPhotographer"];
    [photographer setValue:username forKey:@"name"];
    [newPhoto setValue:timestampString forKey:@"timestamp"];
    [newPhoto setValue:date forKey:@"date"];
    [newPhoto setValue:photographer forKey:@"whoTook"];
    NSLog(@"url is : %@", url);

    [newPhoto setValue:url forKey:@"url"];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
//    [CoreDataHelper savePhoto:photoValues];
    
}

- (IBAction)cancelPhoto:(id)sender {
    [self updateUI];
}



#pragma mark - Navigation

    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        if ([[segue identifier] isEqualToString:@"SwipeToList"])
        {
            if([segue.destinationViewController isKindOfClass:[TableListViewController class]]){
                TableListViewController *cvc = (TableListViewController *)[segue destinationViewController];
                
            }
        }else if ([[segue identifier] isEqualToString:@"SwipeToSettings"])
        {
            if([segue.destinationViewController isKindOfClass:[SettingsViewController class]]){
                SettingsViewController *cvc = (SettingsViewController *)[segue destinationViewController];
                
            }
        }
}

@end
