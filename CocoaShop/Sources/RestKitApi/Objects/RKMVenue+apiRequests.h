//
//  RKMVenue+apiRequests.h
//  CocoaShop
//
//  Created by user on 17.10.13.
//  Copyright (c) 2013 RedPandazLabs. All rights reserved.
//

#import "RKMVenue.h"

@interface RKMVenue (apiRequests)

+(void)venuesFromCoordinate:(CLLocationCoordinate2D)coordinate finishBlock:(void (^)(NSArray *objects,NSDictionary *responseDictionary))finishBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
