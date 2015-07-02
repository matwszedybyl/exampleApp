//
//  Photo.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/25/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *url;

@end
