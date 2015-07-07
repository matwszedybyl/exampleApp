//
//  ImageViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/1/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "ImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.spinner startAnimating];
    long timeStampNum = [self.timestamp longLongValue];
    long currentTime = CFAbsoluteTimeGetCurrent();
    long timeAgo = currentTime - timeStampNum;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeAgo];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSLog(@"%@", [formatter stringFromDate:date]);
    self.timeAgoLabel.text = [NSString stringWithFormat:@"Time ago: %ld seconds", timeAgo];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSCache *cache = [delegate appCache];
    UIImage *image = [cache objectForKey:self.url];
    if(image != nil){
        NSLog(@"imaging cache");
        self.photoView.image = image;
        [self.spinner stopAnimating];
    } else {
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        NSLog(@"pulling photo from camera roll");
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref)
        {
            UIImage *largeimage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:UIImageOrientationRight];
            self.photoView.image = largeimage;

        }
        [self.spinner stopAnimating];

    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
        [self.spinner stopAnimating];

    };
        
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        NSURL *url =[NSURL URLWithString:self.url];

        [assetslibrary assetForURL:url
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
