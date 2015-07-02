//
//  CameraViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "CameraViewController.h"
#import "SimpleViewController.h"
#import "Photo.h"
#import "AppDelegate.h"
#import "CoreDataHelper.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@end

@implementation CameraViewController

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;
AVCaptureVideoPreviewLayer *previewLayer;
CALayer *rootLayer;

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

- (void)updateUI
{
    self.usernameLabel.text = [NSString stringWithFormat:@"Username is: %@", [self usernameString]];
    self.passwordLabel.text = [NSString stringWithFormat:@"Password is: %@", [self passwordString]];
    
    session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput   deviceInputWithDevice:inputDevice error:&error];
    if([session canAddInput:deviceInput]){
        [session addInput:deviceInput];
    }
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [rootLayer setMasksToBounds:YES];
    
    
    CGRect frame = frameforCapture.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer above:0];
    
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    [session addOutput:StillImageOutput];
    [session startRunning];
    
    [self refreshCamera];
    
}

- (void) refreshCamera
{

    
}

-(IBAction)takePhoto:(id)sender
{
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
                 [self saveTimestamp:url];

                 [library assetForURL:assetURL resultBlock:^(ALAsset *asset )
                  {
                      NSLog(@"we have our ALAsset!");
                  }
                         failureBlock:^(NSError *error )
                  {
                      NSLog(@"Error loading asset");
                  }];
             }];
            
            
            
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
          
            imageView.image = image;
            [previewLayer removeFromSuperlayer];
            NSLog(@"Outside block =  %@", url);

            
            

        }
    }];
    
}

-(void) saveTimestamp:(NSString *)url
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
//    NSDictionary *photoValues = [[NSDictionary alloc] init];
//    [photoValues setValue:timestampString forKey:@"timestamp"];
//    [photoValues setValue:date forKey:@"date"];

    
    NSManagedObject *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    
    [newPhoto setValue:timestampString forKey:@"timestamp"];
    [newPhoto setValue:date forKey:@"date"];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
