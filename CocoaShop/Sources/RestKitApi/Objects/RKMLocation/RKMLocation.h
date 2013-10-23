//
//  RKMLocation.h
//  CocoaShop
//
//  Created by user on 22.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RKMVenue;

@interface RKMLocation : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * cc;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSSet *venues;
@end

@interface RKMLocation (CoreDataGeneratedAccessors)

- (void)addVenuesObject:(RKMVenue *)value;
- (void)removeVenuesObject:(RKMVenue *)value;
- (void)addVenues:(NSSet *)values;
- (void)removeVenues:(NSSet *)values;

@end
