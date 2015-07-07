//
//  Photo.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/7/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Photographer *whoTook;

@end
