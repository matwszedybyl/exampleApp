//
//  SimpleViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/25/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.

#import "TableListViewController.h"
#import "Photo.h"
#import "PhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageViewController.h"
#import "CameraViewController.h"
#import "Photographer.h"


@interface TableListViewController ()

@end

@implementation TableListViewController

@synthesize table;
NSCache *cache;
AppDelegate *delegate;
NSUserDefaults *userDefaults;

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"SwipeToCamera" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = [[UIApplication sharedApplication] delegate];
    cache = [delegate appCache];
    NSString *p = [cache objectForKey:@"currentPhotographer"];
    NSLog(@"name is %@", p);
    userDefaults = [delegate userDefaults];
    p = [userDefaults objectForKey:@"currentPhotographer"];
    NSLog(@"name is %@", p);
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:context];
    [fetchRequest setEntity:description];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(timestamp = %@)", @"yes"];
//    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    self.tableData  = [context executeFetchRequest:fetchRequest error:&error];
    
    if(!self.tableData || error){
        NSLog(@"error was found or data is null");
    } else {
        NSLog(@"NO ERROR and Data is there");
    }
//    [self setPhotosIntoCache];
    
}
     
-(void)setPhotosIntoCache
{
    NSString *timestamp = [[NSString alloc]init];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref)
        {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
//            NSData *imageData =  UIImagePNGRepresentation(largeimage);
            NSString *urlString = [myasset valueForProperty:ALAssetPropertyAssetURL];
            NSLog(@"url for image is: %@ . ended",urlString);
            NSString *fakestring = [[NSString alloc] initWithFormat:@" %@ meep", urlString];

            [cache setObject:largeimage forKey:urlString];
            [cache setObject:fakestring forKey:fakestring];

        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    for(int i = 0; i <[self.tableData count]; i++ ){
        Photo *photo =[self.tableData objectAtIndex:i];
        timestamp = photo.timestamp;
        
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        NSURL *url =[NSURL URLWithString:photo.url];
        
        [assetslibrary assetForURL:url
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
}


- (void)fetchPhotoTimeStamps
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (PhotoViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PhotoViewCell";
    
    PhotoViewCell *cell = (PhotoViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PhotoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Photo *photo = [self.tableData objectAtIndex:indexPath.row];
    NSString *timestampString = [NSString stringWithFormat:@"%@", photo.timestamp];
    cell.timestampLabel.text = timestampString;
    
    NSString *urlString = [NSString stringWithFormat:@"%@", photo.url];
    cell.usernameLabel.text = urlString;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"Show Photo" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"Show Photo"])
    {
        if([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
            NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
            PhotoViewCell *cell =  (PhotoViewCell *)[self.table cellForRowAtIndexPath:indexPath];
            Photo *photo = [self.tableData objectAtIndex:indexPath.row];
            ImageViewController *ivc = (ImageViewController *)[segue destinationViewController];
            ivc.timestamp = cell.timestampLabel.text;
            UIImage *image = [cache objectForKey:photo.url];
            NSString *fakestring = [[NSString alloc] initWithFormat:@" %@ meep", photo.url];
            NSString *string  = [cache objectForKey:fakestring];

            if(image!=nil) {
                NSLog(@"image isnt nil");

            } else if (string !=nil) {
                NSLog(@"string isnt nil");

            } else   {
                NSLog(@"both are nil");
                
            }
            ivc.url = cell.usernameLabel.text;
            ivc.photo = photo;
        }
    }else if ([[segue identifier] isEqualToString:@"SwipeToCamera"])
    {
        if([segue.destinationViewController isKindOfClass:[CameraViewController class]]){
            CameraViewController *cvc = (CameraViewController *)[segue destinationViewController];
        }
    }

}



@end
