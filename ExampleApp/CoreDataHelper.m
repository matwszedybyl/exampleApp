//
//  CoreDataHelper.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/29/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "CoreDataHelper.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation CoreDataHelper

+ (void) savePhoto:(NSDictionary *)photoValues
{
    //get instance of app delegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //create managed object context
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if ([appDelegate managedObjectContext] == nil)
    {
        context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext: %@",  context);
    }
    
    NSManagedObject *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
    
    [newPhoto setValue:[photoValues objectForKey:@"timestamp"] forKey:@"timestamp"];
    [newPhoto setValue:[photoValues objectForKey:@"date"] forKey:@"date"];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

@end
