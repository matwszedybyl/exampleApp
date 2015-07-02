//
//  SimpleViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/25/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.

#import "SimpleViewController.h"
#import "Photo.h"
#import "PhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageViewController.h"


@interface SimpleViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SimpleViewController
NSCache *cache;
AppDelegate *delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = [[UIApplication sharedApplication] delegate];
    cache = [delegate appCache];
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
    [self setPhotosIntoCache];
    
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
            NSData *imageData =  UIImagePNGRepresentation(largeimage);
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
        NSString *urlString = photo.url;
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
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            PhotoViewCell *cell =  (PhotoViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            Photo *photo = [self.tableData objectAtIndex:indexPath.row];

            ImageViewController *cvc = (ImageViewController *)segue.destinationViewController;
            cvc.timestamp = cell.timestampLabel.text;
//            NSData *imageData = [cache objectForKey:photo.url];
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
            cvc.url = cell.usernameLabel.text;
            cvc.photo = photo;
        }
    }
}



@end
