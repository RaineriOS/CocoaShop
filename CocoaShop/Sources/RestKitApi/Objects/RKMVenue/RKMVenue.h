//
//  RKMVenue.h
//  CocoaShop
//
//  Created by user on 22.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RKMLocation;

@interface RKMVenue : NSManagedObject

@property (nonatomic, retain) NSNumber * checkinsCount;
@property (nonatomic, retain) NSString * ident;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * usersCount;
@property (nonatomic, retain) RKMLocation *location;

@end
